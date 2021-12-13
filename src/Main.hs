{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Api.WebDriver.Endpoints
import Web.Api.WebDriver

main :: IO ()
main = do
  x <- execWebDriverT defaultWebDriverConfig doLogin
  print x

doLogin :: WebDriverT IO ()
doLogin = do
  navigateTo "http://localhost:8001/login"
  z <- findElements CssSelector "div.alert"
  assertEqual [] z "Errors found"

