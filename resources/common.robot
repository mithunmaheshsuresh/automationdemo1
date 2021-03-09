*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  DatabaseLibrary
Resource  ../data/environment.robot
Library  Process
Library  custom_libs/browserstack.py

*** Variables ***
${BROWSER}                      Chrome
${VERSION}                      89
${DELAY}                        0.5 seconds
${TIMEOUT}                      30 seconds

${Website} =    http://automationpractice.com/index.php
${firstname} =   Mithun
${lastname} =  Suresh
${valide_email} =  test1149@demo.com
${password} =  Test1234
${company} =  Company1
${address1} =  Street 1
${city} =  Chicago
${postcode} =  60606
${phone} =  1234567890
${phone_mobile} =  1234567890


*** Keywords ***



###COMMON KEYWORDS###
Common Setup
    [Arguments]  ${db_user}
    Open Browser  about:blank  ${BROWSER}  alias=main
#    Set Selenium Speed  ${DELAY}
    set selenium timeout  ${TIMEOUT}



Desktop Setup
    Set Window Size  1920  1080
    set global variable  ${PLATFORM}  desktop


End Test
    Run Keyword If Test Failed  Capture Page Screenshot
    Close All Browsers
    Terminate All Processes
    run keyword and continue on failure  disconnect from database

###TEST ENVIRONMENT SETUP###


Close Browser
    Close All Browsers

