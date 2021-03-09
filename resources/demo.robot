*** Settings ***
Documentation    Suite description
Library  SeleniumLibrary
Library  FakerLibrary
Resource  po/SiteEntry.robot
Resource  ../resources/common.robot




*** Keywords ***
Navigate To Website
    [Arguments]  ${Website}  ${BROWSER}
    SiteEntry.Navigate to test website  ${Website}  ${BROWSER}

verify the site has content
    SiteEntry.Verify the content


Navigate to login screen
    Click Element   css:a[class^=login]
    page should contain element  css=#email_create

Validate existing email id cannot be used to create an account
    Input Text  css=#email_create  test@demo.com
    Click Element  css=#SubmitCreate
    Wait Until Element Contains  css=#create_account_error > ol > li  An account using this email address has already been registered. Please enter a valid password or request a new one.



Verify user can register with valid data
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

Verify the my account of the user with registered data
    Click Element  xpath=//a[@href="http://automationpractice.com/index.php?controller=identity"]
    Wait Until Page Contains  Please be sure to update your personal information if it has changed.
    ${compare_name} =  Get Value   css=#firstname
    Should Be Equal  ${compare_name}  Mithun
    Click Element  css:a[class^=logout]


