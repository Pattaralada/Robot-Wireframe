*** Settings ***
Library    SeleniumLibrary
Resource   common.resource

Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Products Page


*** Test Cases ***
Scenario: Access Inventory Without Login Should Redirect
    Delete All Cookies
    Go To    ${URL}inventory.html
    Wait Until Element Is Visible    id:login-button
    Element Should Be Visible    id:login-button
