module Converters.YamlConverter where

import Core.SmallCaps (stringConverter)
import Data.Yaml
import Data.Aeson (Value(..))
import qualified Data.Text as T

-- Converts an entire .yaml config file to small caps
convertYamlFile :: FilePath -> FilePath -> IO ()
convertYamlFile pathIn pathOut = do
    resultBox <- decodeFileEither pathIn
    case resultBox of
        Left err -> print err
        Right tree -> do
            let convertedText = convertYaml tree
            encodeFile pathOut convertedText

-- Helper function to convert the String values inside the YAML file, leaving everything else alone
convertYaml :: Value -> Value
convertYaml (String textData) = String $ T.pack $ stringConverter $ T.unpack textData
convertYaml (Object obj)       = Object $ fmap convertYaml obj
convertYaml (Array arr)       = Array $ fmap convertYaml arr
convertYaml other             = other