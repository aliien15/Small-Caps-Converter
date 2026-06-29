module Converters.TextConverter (convertTextFile) where

import Core.SmallCaps (stringConverter)
import System.IO

convertTextFile :: FilePath -> FilePath -> IO ()
convertTextFile pathIn pathOut = 
    withFile pathIn ReadMode $ \hIn -> do
        hSetEncoding hIn utf8
        textToConvert <- hGetContents hIn
        
        withFile pathOut WriteMode $ \hOut -> do
            hSetEncoding hOut utf8
            
            let convertedText = stringConverter textToConvert
            hPutStr hOut convertedText