*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Resource  po/SiteEntry.robot
Resource  po/Login.robot


*** Test Cases ***
Test title
    [Tags]    DEBUG
    Provided precondition
    When action
    Then check expectations

*** Keywords ***
Navigate To Website
    SiteEntry.Navigate to test website

