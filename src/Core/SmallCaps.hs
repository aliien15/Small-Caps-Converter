module Core.SmallCaps (stringConverter) where

dictionary :: [(Char, Char)]
dictionary = zip "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" "ᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀꜱᴛᴜᴠᴡxʏᴢᴀʙᴄᴅᴇꜰɢʜɪᴊᴋʟᴍɴᴏᴘǫʀꜱᴛᴜᴠᴡxʏᴢ"

-- Attempts to convert a char to a small cap, returning a the value converted if it is a letter,
-- or the samel value if it can't be converted (due to not being a letter)
convertChar :: Char -> Char
convertChar c = case lookup c dictionary of
    Just converted -> converted
    Nothing -> c

-- Converts an entire String to small caps
stringConverter :: String -> String
stringConverter = map convertChar