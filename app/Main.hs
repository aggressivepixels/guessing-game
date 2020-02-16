{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import System.Random (randomRIO)
import Text.Read (readMaybe)

main :: IO ()
main = do
  putStrLn "Guess a number!"
  putStrLn "Please input your guess or \"quit\" to quit!"
  guess =<< (randomRIO (1, 100) :: IO Int)
  where
    guess randomNumber =
      getLine >>= \case
        "quit" -> putStrLn "Goodbye!"
        userGuessStr ->
          case readMaybe userGuessStr :: Maybe Int of
            Just userGuess ->
              case compare userGuess randomNumber of
                EQ -> putStrLn "You win!"
                LT -> putStrLn "Too small!" >> guess randomNumber
                GT -> putStrLn "Too big!" >> guess randomNumber
            Nothing -> putStrLn "Please write a number!" >> guess randomNumber
