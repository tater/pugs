{-# OPTIONS_GHC -fglasgow-exts -cpp #-}

{-|
    Embedded interpreters.

>   As Beren looked into her eyes
>   Within the shadows of her hair,
>   The trembling starlight of the skies
>   He saw there mirrored shimmering...
-}

module Pugs.Embed (
    module Pugs.Embed.Perl5,
    module Pugs.Embed.Haskell,
    module Pugs.Embed.Pugs,
    evalEmbedded
    -- module Pugs.Embed.Ponie,
) where
import Pugs.Embed.Perl5
import Pugs.Embed.Haskell
import Pugs.Embed.Pugs
#ifdef PUGS_HAVE_SMOP
import Pugs.Embed.M0ld
#endif

evalEmbedded :: String -> String -> IO ()
-- evalEmbedded "Pir" = evalParrot
-- evalEmbedded "PIR" = evalParrot
-- evalEmbedded "Parrot" = evalParrot
evalEmbedded "Pugs" = evalPugs
{- evalEmbedded "Haskell" code = do
    evalHaskell code
    return () -}
evalEmbedded "Perl5" = \code -> do
    interp <- initPerl5 "" Nothing
    evalPerl5 code nullEnv 0
    freePerl5 interp
#ifdef PUGS_HAVE_SMOP
evalEmbedded "M0ld" = evalM0ld 
#else
evalEmbedded "M0ld" = \code -> putStrLn "smop embedding is disabled use ./Setup configure --user --flags=SMOP"
#endif
evalEmbedded s = const . fail $ "Cannot evaluate in " ++ s
