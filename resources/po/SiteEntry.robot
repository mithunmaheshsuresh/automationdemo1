*** Settings ***
Library  SeleniumLibrary
Library  DatabaseLibrary
Library  ../custom_libs/server_ip.py

*** Variables ***

*** Keywords ***
Navigate to test website
    Open Browser  http://automationpractice.com/index.php  chrome

Navigate to prod website
    [Arguments]  ${BRAND}
    Set Up Production URL Variables  ${BRAND}
    Go To  ${START_URL}
    log to console  ${START_URL}


