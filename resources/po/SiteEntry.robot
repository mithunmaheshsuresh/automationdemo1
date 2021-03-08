*** Settings ***
Library  SeleniumLibrary
Library  DatabaseLibrary
Library  Process
Resource  ../util.robot
Resource  ../database.robot
Resource  ../../data/environment.robot
Resource  ../../data/zip.robot
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

Set Up Test URL Variables
    [Arguments]  ${BRAND}
    run keyword if  '${ENV_VISIBILITY}' == 'internal'  Set Internal Brand Start URL  ${BRAND}  ELSE  Set External Brand start URL  ${BRAND}
    Brand Default Zip Info  ${BRAND}
    Set Test Variable  ${API_URL}  ${START_URL}
    Set Test Variable  ${OPCO}  ${BRAND}
    set test variable  ${USER}  Regular

Set Up Production URL Variables
    [Arguments]  ${BRAND}
    Set Production Brand start URL  ${BRAND}
    Set Test Variable  ${API_URL}  ${START_URL}
    run keyword if  ${DIRECT_SERVER}  Set URL with direct dynamo server  ${BRAND}
    Set Test Variable  ${OPCO}  ${BRAND}

Set Internal Brand start URL
    [Arguments]  ${BRAND}
    run keyword if  '${BRAND}' == 'PPOD'  Set Test Variable  ${START_URL}  https://${environment}.service.qa.peapod.com
    ...  ELSE  Set Test Variable  ${START_URL}  https://${environment}-${BRAND}.service.qa.peapod.com

Set External Brand start URL
    [Documentation]    This is to be used with the alpha and staging environments
    [Arguments]  ${BRAND}
    run keyword if  '${BRAND}' == 'STSH'  Set Test Variable  ${START_URL}  https://${EXTERNAL_ENV}.stopandshop.com
    run keyword if  '${BRAND}' == 'PPOD'  Set Test Variable  ${START_URL}  https://${EXTERNAL_ENV}.peapod.com
    run keyword if  '${BRAND}' == 'GNTL'  Set Test Variable  ${START_URL}  https://${EXTERNAL_ENV}.giantfood.com
    run keyword if  '${BRAND}' == 'GNTC'  Set Test Variable  ${START_URL}  https://${EXTERNAL_ENV}.giantfoodstores.com
    run keyword if  '${BRAND}' == 'MRTN'  Set Test Variable  ${START_URL}  https://${EXTERNAL_ENV}.martinsfoods.com
    run keyword if  ${STAGING}  run keyword if  ${DIRECT_SERVER}  Set URL with direct dynamo server  ${BRAND}

Brand Default Zip Info
    [Arguments]  ${BRAND}
    run keyword if  '${BRAND}' == 'STSH'  Set Test Variable  ${ZIP_INFO}  ${STSH_1_CITY_ZIP}
    run keyword if  '${BRAND}' == 'GNTL'  Set Test Variable  ${ZIP_INFO}  ${GNTL_ZIP_1_CITY}
    run keyword if  '${BRAND}' == 'GNTC'  Set Test Variable  ${ZIP_INFO}  ${GNTC_2_ZIP_1_CITY}
    run keyword if  '${BRAND}' == 'MRTN'  Set Test Variable  ${ZIP_INFO}  ${MRTN_ZIP_1_CITY}

