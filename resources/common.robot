*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  DatabaseLibrary
Resource  ../data/environment.robot
Library  Process
Library  custom_libs/browserstack.py

*** Variables ***
${BROWSER}                      headlesschrome
${DELAY}                        0.5 seconds
${TIMEOUT}                      30 seconds
${DEVICE}                       iPhone 8 Plus
${REAL_MOBILE}                  True
${BS_LOCAL}                     True
${DESKTOP_SIZE}                 1920x1080
${BSDESKTOP}                    browser:${BSBROWSER},browser_version:${BROWSER_VERSION},os:${OS},os_version:${OS_VERSION},browserstack.local:${BS_LOCAL},resolution:${DESKTOP_SIZE},selenium_version:${SELENIUM_VERSION}
${BSMOBILE}                     device:${DEVICE},real_mobile:${REAL_MOBILE},os_version:${OS_VERSION},browserstack.local:${BS_LOCAL},browserstack.appium_version:${APPIUM_VERSION}
${BSMINITAB}                    device:${DEVICE},real_mobile:${REAL_MOBILE},os_version:${OS_VERSION},browserstack.local:${BS_LOCAL},browserstack.appium_version:${APPIUM_VERSION}
${BSTABLET}                     device:${DEVICE},real_mobile:${REAL_MOBILE},os_version:${OS_VERSION},browserstack.local:${BS_LOCAL},deviceOrientation:landscape,browserstack.appium_version:${APPIUM_VERSION}
${APPIUM_VERSION}               1.9.1
${BSBROWSER}                    Chrome
${BROWSER_VERSION}              76.0
${OS}                           OS X
${OS_VERSION}                   Mojave
${SELENIUM_VERSION}             3.14
${ORIENTATION}                  landscape
${USERNAME}                     rickhanzelin1
${ACCESS_KEY}                   kkosXhvvyuhvb5Zdk9aq


*** Keywords ***
#Begin Suite
#    connect to database using custom params  ${DB_API_MODULE}  ${CONNECTION_STR}
#    set global variable  ${TRANSACTION}  sansTrans=True
#
#End Suite
#    disconnect from database


###COMMON KEYWORDS###
Common Setup
    [Arguments]  ${db_user}
    Open Browser  about:blank  ${BROWSER}  alias=main
#    Set Selenium Speed  ${DELAY}
    set selenium timeout  ${TIMEOUT}
    run keyword if  '${db_user}' == 'podadmin'  connect to database with podadmin
    ...  ELSE IF  '${db_user}' == 'ppaweb01'  connect to database with ppaweb01
    ...  ELSE IF  '${db_user}' == 'prod'  connect to prod database
    ...  ELSE IF  '${db_user}' == 'staging'  connect to staging database with podadmin


Set Test Environment Variable
    set global variable  ${PRODUCTION}  False
    set test variable  ${LOCATION_CHANGE}  False
    set test variable  ${STAGING}  False

Set Production Environment Variable
    set global variable  ${PRODUCTION}  True

Desktop Setup
    Set Window Size  1920  1080
    set global variable  ${PLATFORM}  desktop

Tablet Setup
    Set Window Size  1024  768
    set global variable  ${PLATFORM}  tablet

Minitab Setup
    Set Window Size  768  1024
    set global variable  ${PLATFORM}  minitab

Mobile Setup
    Set Window Size  414  736  #iphone 6 plus resolution
    set global variable  ${PLATFORM}  mobile

End Test
    Run Keyword If Test Failed  Capture Page Screenshot
    Close All Browsers
    Terminate All Processes
    run keyword and continue on failure  disconnect from database

###TEST ENVIRONMENT SETUP###
Begin Test
    [Arguments]  ${breakpoint}
    Common Setup  ppaweb01
    Set Test Environment Variable
    run keyword if  '${breakpoint}' == 'desktop'  Desktop Setup
    ...  ELSE IF  '${breakpoint}' == 'tablet'  Tablet Setup
    ...  ELSE IF  '${breakpoint}' == 'minitab'  Minitab Setup
    ...  ELSE IF  '${breakpoint}' == 'mobile'  Mobile Setup
    ...  ELSE  log to console  declare a breakpoint!



###PODADMIN ENVIRONMENT SETUP###
Begin Slots Test
    [Arguments]  ${breakpoint}
    Common Setup  podadmin
    Set Test Environment Variable
    run keyword if  '${breakpoint}' == 'desktop'  Desktop Setup
    ...  ELSE IF  '${breakpoint}' == 'tablet'  Tablet Setup
    ...  ELSE IF  '${breakpoint}' == 'minitab'  Minitab Setup
    ...  ELSE IF  '${breakpoint}' == 'mobile'  Mobile Setup
    ...  ELSE  log to console  declare a breakpoint!


###PRODUCTION ENVIRONMENT SETUP###
Begin Production Test
    [Arguments]  ${breakpoint}
    Common Setup  prod
    Set Production Environment Variable
    run keyword if  '${breakpoint}' == 'desktop'  Desktop Setup
    ...  ELSE IF  '${breakpoint}' == 'tablet'  Tablet Setup
    ...  ELSE IF  '${breakpoint}' == 'minitab'  Minitab Setup
    ...  ELSE IF  '${breakpoint}' == 'mobile'  Mobile Setup
    ...  ELSE  log to console  declare a breakpoint!

Begin Staging Test
    [Arguments]  ${breakpoint}
    Common Setup  staging
    Set Test Environment Variable
    set test variable  ${STAGING}  True
    run keyword if  '${breakpoint}' == 'desktop'  Desktop Setup
    ...  ELSE IF  '${breakpoint}' == 'tablet'  Tablet Setup
    ...  ELSE IF  '${breakpoint}' == 'minitab'  Minitab Setup
    ...  ELSE IF  '${breakpoint}' == 'mobile'  Mobile Setup
    ...  ELSE  log to console  declare a breakpoint!


###SUPERUSER ENVIRONMENT SETUP
Begin Superuser Test
    [Arguments]  ${breakpoint}
    Common Setup  ppaweb01
    Set Test Environment Variable
    run keyword if  '${breakpoint}' == 'desktop'  Desktop Setup
    ...  ELSE IF  '${breakpoint}' == 'tablet'  Tablet Setup
    ...  ELSE IF  '${breakpoint}' == 'minitab'  Minitab Setup
    ...  ELSE IF  '${breakpoint}' == 'mobile'  Mobile Setup
    ...  ELSE  log to console  declare a breakpoint!


###BROWSERSTACK ENVIRONMENT SETUP###
Begin Browserstack Test
    [Arguments]  ${breakpoint}
    Browserstack Common Setup
    run keyword if  '${breakpoint}' == 'desktop'  Browserstack Desktop Setup
    ...  ELSE IF  '${breakpoint}' == 'tablet'  Browserstack Tablet Setup
    ...  ELSE IF  '${breakpoint}' == 'minitab'  Browserstack Minitab Setup
    ...  ELSE IF  '${breakpoint}' == 'mobile'  Browserstack Mobile Setup
    ...  ELSE  log to console  declare a breakpoint!
    set selenium timeout  ${TIMEOUT}

Browserstack Common Setup
    set test variable  ${REMOTE_URL}  http://${USERNAME}:${ACCESS_KEY}hub-cloud.browserstack.com/wd/hub
#    Set Selenium Speed  ${DELAY}
    Set Test Environment Variable
    connect to database with ppaweb01

Browserstack Desktop Setup
    Open Browser  about:blank  ${BROWSER}  remote_url=${REMOTE_URL}  desired_capabilities=${BSDESKTOP}
    Desktop Setup

Browserstack Tablet Setup
    Open Browser  about:blank  ${BROWSER}  remote_url=${REMOTE_URL}  desired_capabilities=${BSTABLET}
    set global variable  ${PLATFORM}  tablet

Browserstack Minitab Setup
    Open Browser  about:blank  ${BROWSER}  remote_url=${REMOTE_URL}  desired_capabilities=${BSMINITAB}
    set global variable  ${PLATFORM}  minitab

Browserstack Mobile Setup
    Open Browser  about:blank  ${BROWSER}  remote_url=${REMOTE_URL}  desired_capabilities=${BSMOBILE}
    set global variable  ${PLATFORM}  mobile

End Browserstack Test
#    run keyword if  '${PLATFORM}' == 'desktop'  Close All Browsers
    Close All Browsers
    Terminate All Processes
    run keyword and continue on failure  disconnect from database

Close Browser
    Close All Browsers

Reopen Browser
    Open Browser  about:blank  ${BROWSER}  alias=main
    run keyword if  '${PLATFORM}' == 'desktop'  Desktop Setup
    ...  ELSE IF  '${PLATFORM}' == 'tablet'  Tablet Setup
    ...  ELSE IF  '${PLATFORM}' == 'minitab'  Minitab Setup
    ...  ELSE IF  '${PLATFORM}' == 'mobile'  Mobile Setup
    ...  ELSE  log to console  declare a breakpoint!