*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String             # สำคัญมาก: เพื่อใช้คำสั่ง Remove String
Suite Setup       Open Browser To Login Page
Suite Teardown    Close Browser

*** Variables ***
${URL}           https://www.saucedemo.com/
${BROWSER}       chrome
${USERNAME}      standard_user
${PASSWORD}      secret_sauce
${DELAY}         0.5 seconds    # ปรับความเร็วตรงนี้ (ช้าลง 0.5 วินาทีทุก Step)

*** Test Cases ***
Verify Sorting Price Low To High
    [Documentation]    ทดสอบการเรียงลำดับราคาสินค้าจากน้อยไปมาก พร้อม Debug
    Login To Swag Labs
    Select Sorting Option    lohi
    Verify Price Sorting Is Correct
    Sleep    2 seconds

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}

Login To Swag Labs
    Input Text        id:user-name    ${USERNAME}
    Input Password    id:password     ${PASSWORD}
    Click Button      id:login-button
    Wait Until Element Is Visible    class:title

Select Sorting Option
    [Arguments]    ${value}
    Select From List By Value    class:product_sort_container    ${value}

Verify Price Sorting Is Correct
    ${elements}=    Get WebElements    class:inventory_item_price
    ${actual_prices}=    Create List
    
    FOR    ${el}    IN    @{elements}
        ${text}=    Get Text    ${el}
        
        # --- DEBUG: พ่นค่าดิบที่ได้จากเว็บออกมาดู ---
        Log To Console    Raw text from web: ${text}
        
        ${price}=    Remove String    ${text}    $
        ${price_num}=    Convert To Number    ${price}
        
        # --- DEBUG: พ่นค่าที่แปลงเป็นตัวเลขแล้ว ---
        Log To Console    Cleaned price: ${price_num}
        
        Append To List    ${actual_prices}    ${price_num}
    END

    # สร้าง List สำหรับเปรียบเทียบ
    ${expected_prices}=    Copy List    ${actual_prices}
    Sort List    ${expected_prices}

    # --- DEBUG: ดู List ทั้งสองก่อนเทียบกัน ---
    Log To Console    Actual List: ${actual_prices}
    Log To Console    Expected List: ${expected_prices}

    Lists Should Be Equal    ${actual_prices}    ${expected_prices}