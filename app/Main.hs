{-# LANGUAGE LambdaCase #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Control.Monad (liftM2)
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
          case liftM2
                 compare
                 (readMaybe userGuessStr :: Maybe Int)
                 (pure randomNumber) of
            Just EQ -> putStrLn "You win!"
            Just LT -> putStrLn "Too small!" >> guess randomNumber
            Just GT -> putStrLn "Too big!" >> guess randomNumber
            Nothing -> putStrLn "Please write a number!" >> guess randomNumber
