*** Settings ***
Library    SeleniumLibrary
Resource   common.resource

Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser
Test Setup        Go To Products Page


*** Test Cases ***
Scenario: Page Title Should Be Swag Labs
    ${title}=    Get Text    class:app_logo
    Should Be Equal    ${title}    Swag Labs

Scenario: Products Heading Should Be Visible
    ${heading}=    Get Text    class:title
    Should Be Equal    ${heading}    Products

Scenario: Product List Should Not Be Empty
    ${items}=    Get WebElements    class:inventory_item
    ${count}=    Get Length    ${items}
    Should Be True    ${count} > 0    No products found on page

Scenario: Each Product Should Have Name
    ${names}=    Get WebElements    class:inventory_item_name
    FOR    ${el}    IN    @{names}
        ${text}=    Get Text    ${el}
        Should Not Be Empty    ${text}    Found product with empty name
    END

Scenario: Each Product Should Have Valid Price Format
    ${prices}=    Get WebElements    class:inventory_item_price
    FOR    ${el}    IN    @{prices}
        ${text}=    Get Text    ${el}
        Should Start With    ${text}    $    Price does not start with $: ${text}
    END

Scenario: Each Product Should Have Description
    ${descs}=    Get WebElements    class:inventory_item_desc
    FOR    ${el}    IN    @{descs}
        ${text}=    Get Text    ${el}
        Should Not Be Empty    ${text}    Found product with empty description
    END

Scenario: Each Product Should Have Image
    ${images}=    Get WebElements    xpath://div[@class='inventory_item_img']//img
    FOR    ${img}    IN    @{images}
        ${src}=    Get Element Attribute    ${img}    src
        Should Not Be Empty    ${src}    Product image is missing src
    END

Scenario: Each Product Should Have Add To Cart Button
    ${items}=    Get WebElements    class:inventory_item
    ${buttons}=    Get WebElements    xpath://button[contains(text(),'Add to cart')]
    ${item_count}=    Get Length    ${items}
    ${btn_count}=    Get Length    ${buttons}
    Should Be Equal As Integers    ${item_count}    ${btn_count}
    ...    Expected ${item_count} buttons but found ${btn_count}
