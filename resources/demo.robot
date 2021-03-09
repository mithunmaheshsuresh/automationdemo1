*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Resource  po/SiteEntry.robot


*** Test Cases ***

*** Keywords ***
Navigate To Website
    SiteEntry.Navigate to test website

