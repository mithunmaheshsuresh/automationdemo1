*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem



*** Variables ***
${BROWSER}                      Chrome
${VERSION}                      89
${DELAY}                        0.5 seconds
${TIMEOUT}                      30 seconds

${Website} =    http://automationpractice.com/index.php
${firstname} =   Mithun
${lastname} =  Suresh
${valide_email} =  test1178@demo.com
${password} =  Test1234
${company} =  Company1
${address1} =  Street 1
${city} =  Chicago
${postcode} =  60606
${phone} =  1234567890
${phone_mobile} =  1234567890


*** Keywords ***



###COMMON KEYWORDS###

Desktop Setup
    Set Window Size  1920  1080
    set global variable  ${PLATFORM}  desktop


End Test
    Run Keyword If Test Failed  Capture Page Screenshot
    Close All Browsers
    Terminate All Processes


###TEST ENVIRONMENT SETUP###


Close Browser
    Close All Browsers

