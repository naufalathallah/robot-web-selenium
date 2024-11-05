*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${BASE_URL}    http://the-internet.herokuapp.com
${BROWSER}    Chrome
${UNAME}    tomsmith
${PASSWORD}    SuperSecretPassword!
@{LIST_USERNAME}    tomsmith    tom    smith    tomsmith1
&{DICT_USERNAME}    user1=tomsmith    user2=tom    user3=smith    user4=tomsmith1

${INPUT_USERNAME}    id:username
${INPUT_PASSWORD}    id:password
${BTN_LOGIN}         //button[@type="submit"]
${BTN_LOGOUT}        //a[@href="/logout"]

*** Test Cases ***
TC 1: Login
    Login To Herokuapp    ${UNAME}    ${PASSWORD}
    Logout From Herokuapp
    Close Browser

TC 2: Login list
    Login To Herokuapp    ${LIST_USERNAME}[0]    ${PASSWORD}
    Logout From Herokuapp
    Close Browser

TC 3: Login dict
    Login To Herokuapp    ${DICT_USERNAME}[user1]    ${PASSWORD}
    Logout From Herokuapp
    Close Browser

TC 4: A/B Testing
    Given I am on the base page of herokuapp
    When I click a/b testing link
    Then I can see the text variation
    Close Browser

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

I am on the base page of herokuapp
    Open Browser    ${BASE_URL}    ${BROWSER}

I click a/b testing link
    Click Element    //a[text()="A/B Testing"]

I can see the text variation
    ${TEXT_DISPLAYED}=    Get Text    //h3
    Log To Console    ${TEXT_DISPLAYED}

    IF  "${TEXT_DISPLAYED}"=="A/B Test Control"
        Log To Console    Control
    ELSE IF    "${TEXT_DISPLAYED}"=="A/B Test Variation 1"
        Log To Console    Variation
    END
    