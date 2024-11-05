*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}    http://the-internet.herokuapp.com
${BROWSER}    Chrome
${UNAME}    tomsmith
${PASSWORD}    SuperSecretPassword!

${INPUT_USERNAME}    id:username
${INPUT_PASSWORD}    id:password
${BTN_LOGIN}         //button[@type="submit"]
${BTN_LOGOUT}        //a[@href="/logout"]

*** Keywords ***
Login To Herokuapp
    [Arguments]    ${user}    ${pass}
    Open Browser    ${BASE_URL}/login    ${BROWSER}
    Input Text    ${INPUT_USERNAME}    ${user}
    Input Text    ${INPUT_PASSWORD}    ${pass}
    Click Element    ${BTN_LOGIN}
    Element Text Should Be    //h4    Welcome to the Secure Area. When you are done click logout below.

Logout From Herokuapp
    Click Element    ${BTN_LOGOUT}

*** Test Cases ***
TC 1: Login
    Login To Herokuapp    ${UNAME}    ${PASSWORD}
    Logout From Herokuapp
    Close Browser