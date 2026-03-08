*** Settings ***
Library    SeleniumLibrary
Resource   common.resource

Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Products Page


*** Test Cases ***
Scenario: Cart Badge Should Show 1 After Adding One Item
    Cart Count Should Be    0
    Click First Add To Cart Button
    Cart Count Should Be    1

Scenario: Add To Cart Button Should Change To Remove
    Click First Add To Cart Button
    Wait Until Element Is Visible    xpath://button[contains(text(),'Remove')]
    Element Should Be Visible       xpath://button[contains(text(),'Remove')]

Scenario: Add Multiple Items Should Update Cart Badge
    ${buttons}=    Get WebElements    xpath://button[contains(text(),'Add to cart')]
    ${count}=    Set Variable    0
    FOR    ${btn}    IN    @{buttons}[:3]
        Click Element    ${btn}
        ${count}=    Evaluate    ${count} + 1
        Cart Count Should Be    ${count}
    END

Scenario: Remove Item Should Decrease Cart Badge
    Click First Add To Cart Button
    Cart Count Should Be    1
    Click Element    xpath://button[contains(text(),'Remove')]
    Cart Count Should Be    0

Scenario: Remove Button Should Revert To Add To Cart
    Click First Add To Cart Button
    Click Element    xpath://button[contains(text(),'Remove')]
    Wait Until Element Is Visible    xpath://button[contains(text(),'Add to cart')]
    Element Should Be Visible       xpath://button[contains(text(),'Add to cart')]

Scenario: Add All Items To Cart
    ${buttons}=    Get WebElements    xpath://button[contains(text(),'Add to cart')]
    ${total}=    Get Length    ${buttons}
    FOR    ${btn}    IN    @{buttons}
        Click Element    ${btn}
    END
    Cart Count Should Be    ${total}
