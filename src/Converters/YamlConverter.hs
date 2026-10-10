module Converters.YamlConverter where

import Core.SmallCaps (stringConverter)
import Data.Yaml
import Data.Aeson ()
import qualified Data.Text as T

convertYamlFile :: FilePath -> FilePath -> IO ()
convertYamlFile pathIn pathOut = do
    resultBox <- decodeFileEither pathIn
    case resultBox of
        Left err   -> print err
        Right tree -> encodeFile pathOut (convertYaml tree)

convertYaml :: Value -> Value
convertYaml (String textData) = String $ T.pack $ stringConverter $ T.unpack textData
convertYaml (Object obj)      = Object $ fmap convertYaml obj
convertYaml (Array arr)       = Array $ fmap convertYaml arr
convertYaml other             = other