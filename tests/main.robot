*** Settings ***
Documentation  This test covers basic features for the website regression test
Library  SeleniumLibrary
Resource  ../resources/demo.robot



*** Variables ***
${firstname} =   Mithun
${lastname} =  Suresh
${valide_email} =  test1117@demo.com
${password} =  Test1234
${company} =  Company1
${address1} =  Street 1
${city} =  Chicago
${postcode} =  60606
${phone} =  1234567890
${phone_mobile} =  1234567890


*** Test Cases ***
#User is able to navigate to website and view the content
#    [Tags]  SiteEntry
#    Open Browser  http://automationpractice.com/index.php  chrome
#    page should contain element  css:img.logo
#    page should contain element  css:input[class^=search_query]
#    Close All Browsers

#Already registered user is not allowed to register
#    [Tags]  InvalidLogin
#    Open Browser  http://automationpractice.com/index.php  chrome
#    page should contain element  css:img.logo
#    page should contain element  css:input[class^=search_query]
#    Click Element   css:a[class^=login]
#    page should contain element  css=#email_create
#    Input Text  css=#email_create  test@demo.com
#    Click Element  css=#SubmitCreate
#    Wait Until Element Contains  css=#create_account_error > ol > li  An account using this email address has already been registered. Please enter a valid password or request a new one.
#    Close All Browsers


Verify user is able to register with valid credentials
    [Tags]  ValidLogin
    Open Browser  http://automationpractice.com/index.php  chrome
    page should contain element  css:img.logo
    page should contain element  css:input[class^=search_query]
    Click Element   css:a[class^=login]
    page should contain element  css=#email_create
    Input Text  css=#email_create  ${valide_email}
    Click Element  css=#SubmitCreate
    Wait Until Page Contains  Your personal information
    Click Element  css=#id_gender1
    Input Text  css=#customer_firstname  ${firstname}
    Input Text  css=#customer_lastname  ${lastname}
    Input Text  css=#passwd  ${password}
    Page Should Contain List  css=#days
    Page Should Contain List  css=#months
    Page Should Contain List  css=#years
    Select From List By Value  css=#days  1
    Select From List By Index  css=#months  1
    Select From List By Value  css=#years  1950
    Input Text  css=#firstname  ${firstname}
    Input Text  css=#lastname  ${lastname}
    Input Text  css=#company  ${company}
    Input Text  css=#address1  ${address1}
    Input Text  css=#city  ${city}
    Select From List By Label  css=#id_state  Illinois
    Input Text  css=#postcode  ${postcode}
    Input Text  css=#phone  ${phone}
    Input Text  css=#phone_mobile  ${phone_mobile}
    Clear Element Text  css=#alias
    Input Text  css=#alias  Home address
    Click Button  css=#submitAccount
    Page Should Contain  My account
    page should contain element  css:a[class^=logout]
    Click Element  xpath=//a[@href="http://automationpractice.com/index.php?controller=identity"]
    Wait Until Page Contains  Please be sure to update your personal information if it has changed.
    ${compare_name} =  Get Value   css=#firstname
    Should Be Equal  ${compare_name}  Mithun
    Click Element  css:a[class^=logout]
    Close All Browsers










