*** Settings ***
Library    SeleniumLibrary
Resource   common.resource

Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Products Page


*** Test Cases ***
Scenario: Click Product Name Should Go To Detail Page
    ${first_name}=    Get Text    xpath:(//div[@class='inventory_item_name'])[1]
    Click Element    xpath:(//div[@class='inventory_item_name'])[1]
    Wait Until Element Is Visible    class:inventory_details
    ${detail_name}=    Get Text    class:inventory_details_name
    Should Be Equal    ${first_name}    ${detail_name}

Scenario: Click Cart Icon Should Go To Cart Page
    Click Element    class:shopping_cart_link
    Wait Until Element Is Visible    class:title
    ${heading}=    Get Text    class:title
    Should Be Equal    ${heading}    Your Cart

Scenario: Click Hamburger Menu Should Open Nav Menu
    Click Element    id:react-burger-menu-btn
    Wait Until Element Is Visible    class:bm-menu
    Element Should Be Visible    class:bm-menu
