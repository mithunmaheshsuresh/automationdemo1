*** Settings ***
Library  SeleniumLibrary
Library  DatabaseLibrary
Library  FakerLibrary
Library  ../custom_libs/fakeData.py

*** Variables ***

*** Keywords ***
Navigate to test website
    [Arguments]  ${Website}  ${BROWSER}
    Open Browser  ${Website}  ${BROWSER}

Verify the content
    Wait Until Element Is Visible  css:img.logo
    page should contain element  css:img.logo
    page should contain element  css:input[class^=search_query]



