{-# OPTIONS_GHC -fglasgow-exts #-}

module PIL.Native.Objects (
    ObjectSpace,
    dumpObjSpace,
    newObject,
    getAttr, setAttr, addAttr,
) where
import PIL.Native.Coerce
import PIL.Native.Types
import PIL.Native.Pretty
import System.Mem.Weak
import Control.Monad.State

type ObjectSpace = SeqOf (Weak NativeObj)

dumpObjSpace :: ObjectSpace -> IO ()
dumpObjSpace ptrs = mapM_ dumpObj (elems ptrs)
    where
    dumpObj ptr = do
        rv <- deRefWeak ptr
        case rv of
            Just obj -> putStrLn $ "#obj# " ++ pretty obj
            Nothing  -> return ()

getAttr :: MonadSTM m => NativeObj -> NativeStr -> m Native
getAttr obj att = do
    attrs <- liftSTM $ readTVar (o_attrs obj)
    case attrs `fetch` att of
        Just val -> return val
        Nothing  -> failWith "no such attribute" att

setAttr :: MonadSTM m => NativeObj -> NativeStr -> Native -> m ()
setAttr obj att val = do
    let tvar = o_attrs obj
    attrs <- liftSTM $ readTVar tvar
    -- unless (exists attrs att) $ failWith "no such attribute" att
    liftSTM $ writeTVar tvar (insert attrs att val)

addAttr :: MonadSTM m => NativeObj -> NativeStr -> m ()
addAttr obj att = do
    let tvar = o_attrs obj
    attrs <- liftSTM $ readTVar tvar
    when (exists attrs att) $ failWith "already got attribute" att
    liftSTM $ writeTVar tvar (insert attrs att nil)

newObject :: (MonadState ObjectSpace m, MonadIO m, MonadSTM m) =>
    NativeObj -> NativeMap -> m NativeObj
newObject cls attrs = do
    tvar  <- liftSTM $ newTVar attrs
    objs  <- get
    let obj = MkObject oid cls tvar
        oid = size objs
    ptr <- liftIO $ mkWeak tvar obj Nothing
    put (insert objs oid ptr)
    return obj
