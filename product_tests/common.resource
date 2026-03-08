*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String


*** Variables ***
${URL}           https://www.saucedemo.com/
${BROWSER}       chrome
${USERNAME}      standard_user
${PASSWORD}      secret_sauce
${DELAY}         0.3 seconds


*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login To Swag Labs

Login To Swag Labs
    Input Text        id:user-name    ${USERNAME}
    Input Password    id:password     ${PASSWORD}
    Click Button      id:login-button

Go To Products Page
    Go To    ${URL}inventory.html
    Wait Until Element Is Visible    class:title

Click First Add To Cart Button
    ${btn}=    Get WebElements    xpath://button[contains(text(),'Add to cart')]
    Click Element    ${btn}[0]

Cart Count Should Be
    [Arguments]    ${expected}
    ${expected_int}=    Convert To Integer    ${expected}
    IF    ${expected_int} == 0
        Element Should Not Be Visible    class:shopping_cart_badge
    ELSE
        ${badge}=    Get Text    class:shopping_cart_badge
        Should Be Equal As Integers    ${badge}    ${expected_int}
    END
