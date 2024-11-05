*** Settings ***
# Library    SeleniumLibrary
Library    ../lib/keywords.py

*** Variables ***
${BASE_URL}    http://the-internet.herokuapp.com
${BROWSER}    Chrome
${UNAME}    tomsmith
${PASSWORD}    SuperSecretPassword!
@{LIST_USERNAME}    tomsmith    tom    smith    tomsmith1
&{DICT_USERNAME}    user1=tomsmith    user2=tom    user3=smith    user4=tomsmith1

${INPUT_USERNAME}    username
${INPUT_PASSWORD}    password
${BTN_LOGIN}         //button[@type="submit"]
${BTN_LOGOUT}        //a[@href="/logout"]

*** Test Cases ***
TC 1: Login
    Login To Herokuapp    ${UNAME}    ${PASSWORD}
    Logout From Herokuapp
    Sel Close Browser

TC 2: Login list
    Login To Herokuapp    ${LIST_USERNAME}[0]    ${PASSWORD}
    Logout From Herokuapp
    Sel Close Browser

TC 3: Login dict
    Login To Herokuapp    ${DICT_USERNAME}[user1]    ${PASSWORD}
    Logout From Herokuapp
    Sel Close Browser

TC 4: A/B Testing
    Given I am on the base page of herokuapp
    When I click a/b testing link
    Then I can see the text variations
    And The text contains one of the variations
    Sel Close Browser

# TC 4: Checkboxes For loop
#     Given I am on the base page of herokuapp
#     When I click checkboxes link
#     And I click all the checkboxes
#     Close Browser

*** Keywords ***
Login To Herokuapp
    [Arguments]    ${user}    ${pass}
    Sel Open Browser    ${BASE_URL}/login
    Sel Input Text By Id   ${INPUT_USERNAME}    ${user}
    Sel Input Text By Id    ${INPUT_PASSWORD}    ${pass}
    Sel Click Element By Xpath    ${BTN_LOGIN}
    Sel Element Text By Xpath Should Be    //h4    Welcome to the Secure Area. When you are done click logout below.

Logout From Herokuapp
    Sel Click Element By Xpath   ${BTN_LOGOUT}

I am on the base page of herokuapp
    Sel Open Browser    ${BASE_URL}   

I click a/b testing link
    Sel Click Element By Xpath    //a[text()="A/B Testing"]

I can see the text variations
    ${TEXT_DISPLAYED}=    Sel Get Text By Xpath  //h3
    Log To Console    ${TEXT_DISPLAYED}

    IF  "${TEXT_DISPLAYED}"=="A/B Test Control"
        Log To Console    Control
    ELSE IF    "${TEXT_DISPLAYED}"=="A/B Test Variation 1"
        Log To Console    Variation
    END
    
The text contains one of the variations
    ${TEXT_DISPLAYED}=    Sel Get Text By Xpath  //h3
    Run Keyword If    "${TEXT_DISPLAYED}" == "A/B Test Control" or "${TEXT_DISPLAYED}" == "A/B Test Variation 1"
    ...    Log To Console   "Contains variation"


# I click checkboxes link
#     Click Element    //a[text()="Checkboxes"]

# I click all the checkboxes
#     @{LIST_CHECKBOX}    Get WebElements    //form/input
#     FOR  ${i}  IN  @{LIST_CHECKBOX}
#         Log To Console    ${i}
#         Click Element    ${i}
#     END
    