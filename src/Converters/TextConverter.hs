module Converters.TextConverter where

import Core.SmallCaps (stringConverter)

-- Converts an entire .txt file to small caps
convertTextFile :: FilePath -> FilePath -> IO()
convertTextFile pathIn pathOut = do
    textToConvert <- readFile pathIn
    let convertedText = stringConverter textToConvert
    writeFile pathOut convertedText