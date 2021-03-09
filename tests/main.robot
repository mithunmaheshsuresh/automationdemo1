*** Settings ***
Documentation  This test covers basic features for the website regression test
Library  SeleniumLibrary
Library  FakerLibrary
Resource  ../resources/demo.robot
Resource  ../resources/common.robot






*** Test Cases ***
User is able to navigate to website and view the content
    [Tags]  WebsiteAccess
    Navigate To Website  ${Website}  ${BROWSER}
    verify the site has content
    Close Browser

Already registered user is not allowed to register
    [Tags]  InvalidLogin
    Navigate To Website  ${Website}  ${BROWSER}
    Verify the site has content
    Navigate to login screen
    Validate existing email id cannot be used to create an account
    Close Browser

Verify user is able to register with valid credentials
    Navigate To Website  ${Website}  ${BROWSER}
    Verify the site has content
    Navigate to login screen
    Verify user can register with valid data
    Verify the my account of the user with registered data
    Close Browser










