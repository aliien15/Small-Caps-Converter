module Converters.TextConverter (convertTextFile) where

import Core.SmallCaps (stringConverter)

convertTextFile :: FilePath -> FilePath -> IO ()
convertTextFile pathIn pathOut = do
    textToConvert <- readFile pathIn
    writeFile pathOut (stringConverter textToConvert)