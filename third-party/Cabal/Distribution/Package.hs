-----------------------------------------------------------------------------
-- |
-- Module      :  Distribution.Package
-- Copyright   :  Isaac Jones 2003-2004
-- 
-- Maintainer  :  Isaac Jones <ijones@syntaxpolice.org>
-- Stability   :  alpha
-- Portability :  portable
--
-- Packages are fundamentally just a name and a version.

{- All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.

    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.

    * Neither the name of Isaac Jones nor the names of other
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. -}

module Distribution.Package (
	-- * Package ids
	PackageIdentifier(..),
        parsePackageName,

        -- * Package dependencies
        Dependency(..),
        thisPackageVersion,
        notThisPackageVersion,

	-- * Package classes
	Package(..), packageName, packageVersion,
	PackageFixedDeps(..),

  -- * Deprecated compat stuff
  showPackageId,
  ) where

import Distribution.Version
         ( Version(..), VersionRange(AnyVersion,ThisVersion), notThisVersion )

import Distribution.Text (Text(..), display)
import qualified Distribution.Compat.ReadP as Parse
import Distribution.Compat.ReadP ((<++))
import qualified Text.PrettyPrint as Disp
import Text.PrettyPrint ((<>), (<+>))
import qualified Data.Char as Char ( isDigit, isAlphaNum )
import Data.List ( intersperse )

-- | The name and version of a package.
data PackageIdentifier
    = PackageIdentifier {
	pkgName    :: String, -- ^The name of this package, eg. foo
	pkgVersion :: Version -- ^the version of this package, eg 1.2
     }
     deriving (Read, Show, Eq, Ord)

instance Text PackageIdentifier where
  disp (PackageIdentifier n v) = case v of
    Version [] _ -> Disp.text n -- if no version, don't show version.
    _            -> Disp.text n <> Disp.char '-' <> disp v

  parse = do
    n <- parsePackageName
    v <- (Parse.char '-' >> parse) <++ return (Version [] [])
    return (PackageIdentifier n v)

parsePackageName :: Parse.ReadP r String
parsePackageName = do ns <- Parse.sepBy1 component (Parse.char '-')
                      return (concat (intersperse "-" ns))
  where component = do 
	   cs <- Parse.munch1 Char.isAlphaNum
	   if all Char.isDigit cs then Parse.pfail else return cs
	-- each component must contain an alphabetic character, to avoid
	-- ambiguity in identifiers like foo-1 (the 1 is the version number).

-- ------------------------------------------------------------
-- * Package dependencies
-- ------------------------------------------------------------

data Dependency = Dependency String VersionRange
                  deriving (Read, Show, Eq)

instance Text Dependency where
  disp (Dependency name ver) =
    Disp.text name <+> disp ver

  parse = do name <- parsePackageName
             Parse.skipSpaces
             ver <- parse <++ return AnyVersion
             Parse.skipSpaces
             return (Dependency name ver)

thisPackageVersion :: PackageIdentifier -> Dependency
thisPackageVersion (PackageIdentifier n v) =
  Dependency n (ThisVersion v)

notThisPackageVersion :: PackageIdentifier -> Dependency
notThisPackageVersion (PackageIdentifier n v) =
  Dependency n (notThisVersion v)

-- | Class of things that can be identified by a 'PackageIdentifier'
--
-- Types in this class are all notions of a package. This allows us to have
-- different types for the different phases that packages go though, from
-- simple name\/id, package description, configured or installed packages.
--
class Package pkg where
  packageId :: pkg -> PackageIdentifier

packageName    :: Package pkg => pkg -> String
packageName     = pkgName    . packageId

packageVersion :: Package pkg => pkg -> Version
packageVersion  = pkgVersion . packageId

instance Package PackageIdentifier where
  packageId = id

-- | Subclass of packages that have specific versioned dependencies.
--
-- So for example a not-yet-configured package has dependencies on version
-- ranges, not specific versions. A configured or an already installed package
-- depends on exact versions. Some operations or data structures (like
--  dependency graphs) only make sense on this subclass of package types.
--
class Package pkg => PackageFixedDeps pkg where
  depends :: pkg -> [PackageIdentifier]

-- ---------------------------------------------------------------------------
-- Deprecated compat stuff

{-# DEPRECATED showPackageId "use the Text class instead" #-}
showPackageId :: PackageIdentifier -> String
showPackageId = display
