module Main where

import System.Environment (getArgs)
import System.FilePath ((</>), (<.>))
import Converters.TextConverter (convertTextFile)
import Converters.YamlConverter (convertYamlFile)
import Converters.PropertiesConverter (convertPropertiesFile)

main :: IO ()
main = do
    args <- getArgs
    runCommand args

-- Handle the arguments provided by the user
runCommand :: [String] -> IO()
runCommand ["text", inPath, outPath] = convertTextFile ("data" </> inPath <.> "txt") ("data" </> outPath <.> "txt")
runCommand ["yaml", inPath, outPath] = convertYamlFile ("data" </> inPath <.> "yaml") ("data" </> outPath <.> "yaml")
runCommand ["properties", inPath, outPath] = convertPropertiesFile ("data" </> inPath <.> "properties") ("data" </> outPath <.> "properties")
runCommand _ = putStrLn "Incorrect arguments! Correct usage: '<text|yaml|properties> <input path> <output path>'"