module Converters.PropertiesConverter where

import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import System.IO (withFile, IOMode(ReadMode, WriteMode), hSetEncoding, utf8)
import Core.SmallCaps (stringConverter)
import qualified Data.ByteString as B
import Data.Text.Encoding (decodeUtf8, encodeUtf8)

data PropertyLine
    = KeyValue T.Text T.Text
    | Comment T.Text
    | Blank
    deriving (Show, Eq)

-- Breaks the String at the first ':' or '=', then drops that delimiter from the value
splitKeyValue :: T.Text -> (T.Text, T.Text)
splitKeyValue text = 
    let 
        (key, valueWithDelimiter) = T.break (`elem` [':', '=']) text
        cleanValue = T.drop 1 valueWithDelimiter
    in (key, cleanValue)

-- Turns a T.Text line into a PropertyLine
parseLine :: T.Text -> PropertyLine
parseLine text
    | T.null text                                                      = Blank
    | T.isPrefixOf (T.pack "!") text || T.isPrefixOf (T.pack "#") text = Comment text
    | otherwise                                                        = uncurry KeyValue (splitKeyValue text)

-- Converts a singular line to small caps, leaving comments and blank lines as they were initially
convert :: PropertyLine -> PropertyLine
convert Blank                = Blank
convert (Comment c)          = Comment c
convert (KeyValue key value) = KeyValue key $ T.pack $ stringConverter $ T.unpack value

-- Turns a Property Line back into a T.Text
renderLine :: PropertyLine -> T.Text
renderLine Blank = T.empty
renderLine (Comment c) = c
renderLine (KeyValue key value) = T.concat [key, T.pack "=", value]

-- Converts an entire .properties config file to small caps
convertPropertiesFile :: FilePath -> FilePath -> IO ()
convertPropertiesFile pathIn pathOut = do
    rawBytes <- B.readFile pathIn
    
    let rawText = decodeUtf8 rawBytes
    
    let contentLines = T.lines rawText
    let processedLines = map (renderLine . convert . parseLine) contentLines
    let finalOutput = T.unlines processedLines
    
    B.writeFile pathOut (encodeUtf8 finalOutput)