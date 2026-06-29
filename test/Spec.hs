module Main where

import Test.QuickCheck
import Core.SmallCaps (stringConverter)

-- Property 1: The converter should never add or remove characters.
-- The standard length of the input must exactly match the length of the output.
prop_lengthPreserved :: String -> Bool
prop_lengthPreserved input = length input == length (stringConverter input)

-- Property 2: Idempotence.
-- If you run the converter on a string, and then run the converter AGAIN 
-- on that exact same output, the result should not change.
prop_idempotence :: String -> Bool
prop_idempotence input = stringConverter input == (stringConverter . stringConverter) input

-- Main entry point to run the tests
main :: IO ()
main = do
    putStrLn "\n=== Running Small Caps Property Tests ==="
    
    putStrLn "Testing Length Preservation..."
    quickCheck prop_lengthPreserved
    
    putStrLn "\nTesting Idempotence (Double-Conversion Equality)..."
    quickCheck prop_idempotence
    
    putStrLn "=== All tests completed! ===\n"