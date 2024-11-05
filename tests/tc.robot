*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${UNAME}    tomsmith
${PASSWORD}    SuperSecretPassword!

*** Keywords ***
Login To Herokuapp
    Open Browser    http://the-internet.herokuapp.com/login    Chrome
    Input Text    id:username    ${UNAME}
    Input Text    id:password    ${PASSWORD}
    Click Element    //button[@type="submit"]
    Element Text Should Be    //h4    Welcome to the Secure Area. When you are done click logout below.

Logout From Herokuapp
    Click Element    //a[@href="/logout"]

*** Test Cases ***
TC 1: Login
    Login To Herokuapp
    Logout From Herokuapp
    Close Browser