{-# OPTIONS_GHC -Wwarn #-}

module Vere.Pier where

import UrbitPrelude

import Vere.Pier.Types

import qualified Data.Vector    as V
import qualified System.Entropy as Ent
import qualified Vere.Log       as Log
import qualified Vere.Persist   as Persist
import qualified Vere.Serf      as Serf

import Vere.Serf (Serf, SerfState(..))


--------------------------------------------------------------------------------

ioDrivers = [] :: [IODriver]


--------------------------------------------------------------------------------

genEntropy :: IO Word512
genEntropy = fromIntegral . view (from atomBytes) <$> Ent.getEntropy 64

generateBootSeq :: Ship -> Pill -> IO BootSeq
generateBootSeq ship Pill{..} = do
    ent <- genEntropy
    let ovums = preKern ent <> pKernelOvums <> pUserspaceOvums
    pure $ BootSeq ident pBootFormulas ovums
  where
    ident       = LogIdentity ship True (fromIntegral $ length pBootFormulas)
    preKern ent = [ Ovum (Path ["", "term", "1"]) (Boot $ Fake $ who ident)
                  , Ovum (Path ["", "arvo"])      (Whom ship)
                  , Ovum (Path ["", "arvo"])      (Wack ent)
                  ]


--------------------------------------------------------------------------------

{-
    This is called to make a freshly booted pier. It assigns an identity
    to an event log and takes a chill pill.
-}
boot :: FilePath -> FilePath -> Ship -> IO (Serf, EventLog, SerfState)
boot pillPath top ship = do
  let logPath = top <> "/.urb/log"

  pill <- loadFile @Pill pillPath >>= \case
            Left l  -> error (show l)
            Right p -> pure p


  seq@(BootSeq ident _ _) <- generateBootSeq ship pill

  Log.wipeEvents logPath -- TODO XX
  log <- Log.open logPath

  Log.writeIdent log ident

  serf             <- Serf.startSerfProcess top
  (events, serfSt) <- Serf.bootFromSeq serf seq

  Serf.requestSnapshot serf serfSt

  writeJobs log events

  pure (serf, log, serfSt)

{-
    What we really want to do is write the log identity and then do
    normal startup, but writeIdent requires a full log state
    including input/output queues.
-}
resume :: FilePath -> IO (Serf, EventLog, SerfState)
resume top = do
  log    <- Log.open (top <> "/.urb/log")
  ident  <- Log.readIdent log
  lastEv <- Log.latestEventNumber log
  serf   <- Serf.startSerfProcess top
  serfSt <- Serf.replay serf ident lastEv (readJobs log)

  Serf.requestSnapshot serf serfSt

  pure (serf, log, serfSt)

writeJobs :: EventLog -> [Job] -> IO ()
writeJobs log jobs = Persist.writeEvents log (fromJob <$> jobs)
  where
    fromJob :: Job -> (Word64, Atom)
    fromJob (Job eventId mug payload) =
      (fromIntegral eventId, jam (toNoun (mug, payload)))

readJobs :: EventLog -> EventId -> Word64 -> IO (V.Vector Job)
readJobs log fst len = do
    events <- Log.readEvents log fst len
    traverse toJob events
  where
    toJob :: (Word64, Atom) -> IO Job
    toJob (eventId, atom) = do
      noun           <- cueExn atom
      (mug, payload) <- fromNounExn noun
      pure $ Job (fromIntegral eventId) mug payload

-- Run Pier --------------------------------------------------------------------

{-
performCommonPierStartup :: Serf.Serf
                         -> TQueue Ovum
                         -> TQueue (Writ [Eff])
                         -> TQueue (Writ [Eff])
                         -> LogState
                         -> IO Pier
performCommonPierStartup serf computeQ persistQ releaseQ logState = do
  for ioDrivers $ \x -> do
    bootMessage <- bornEvent x
    atomically $ writeTQueue computeQ bootMessage

  driverThreads <- for ioDrivers $ \x -> do
    startDriver x (writeTQueue computeQ)

  -- TODO: Don't do a bunch of extra work; we send all events to all drivers
  portingThread <- async $ do
    forever $ do
      r <- atomically (readTQueue releaseQ)
      for_ driverThreads $ \(_, k) ->
        for_ (payload r) $ \eff ->
          k eff

  Serf.workerThread serf (readTQueue computeQ) undefined

  pure (Pier{..})
-}
