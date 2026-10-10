module Converters.PropertiesConverter where

import qualified Data.Text as T
import qualified Data.Text.IO as TIO
import Core.SmallCaps (stringConverter)

data PropertyLine
    = KeyValue T.Text T.Text
    | Comment T.Text
    | Blank
    deriving (Show, Eq)

parseLine :: T.Text -> PropertyLine
parseLine text
    | T.null text = Blank
    | T.isPrefixOf (T.pack "!") text || T.isPrefixOf (T.pack "#") text = Comment text
    | otherwise = let (k, v) = T.break (`elem` [':', '=']) text in KeyValue k (T.drop 1 v)

convert :: PropertyLine -> PropertyLine
convert (KeyValue key value) = KeyValue key $ T.pack $ stringConverter $ T.unpack value
convert other                = other

renderLine :: PropertyLine -> T.Text
renderLine Blank                = T.empty
renderLine (Comment c)          = c
renderLine (KeyValue key value) = T.concat [key, T.pack "=", value]

convertPropertiesFile :: FilePath -> FilePath -> IO ()
convertPropertiesFile pathIn pathOut = do
    rawText <- TIO.readFile pathIn
    let processedLines = map (renderLine . convert . parseLine) (T.lines rawText)
    TIO.writeFile pathOut (T.unlines processedLines)