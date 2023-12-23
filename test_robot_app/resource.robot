*** Settings ***
Documentation     ****A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${URL}                https://fakestore.testelka.pl/
${BROWSER}            chrome
${DELAY}              0
${VALID_USER}         tester.21633
${VALID_PASSWORD}     test_demo_21633
${INVALID_USER}       invalid
${INVALID_PASSWORD}   invalid
${LOGIN_URL}          https://fakestore.testelka.pl/moje-konto/
${SHOP_URL}           https://fakestore.testelka.pl/shop/

# Unlimited Promo Codes:
${PC_250}    kwotowy250
${PC_10%}    10procent
# Single Promo Code:
${PC_25S}    kwotowy250pojedynczy
# Promo Code for products under 3000 PLN
${PC_300}    kwotowy300
# Promo Code for products without promotions
${PC_30P}    kwotowy300bezpromocji
# Promo Code for single use
${PC_10S}    10procent1
# Promo Code for product "Windsurfing" category
${PC_350}    10procent1

*** Keywords ***
Open Browser To Shop Page
    Open Browser    ${SHOP_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Hide Dismiss Link Notice
    Shop Page Should Be Open

# woocommerce-store-notice__dismiss-link - click on element to continue testing
Hide Dismiss Link Notice
    Click Element    xpath:/html/body/p/a
    
Shop Page Should Be Open
    Title Should Be    Sklep – FakeStore

# Product Category: e.g. Windsurfing
Select Product Category
    Click Element    xpath://*[@id="main"]/ul/li[1]/a/h2

# Add to cart: “Egipt - El Gouna”
Add Product To The Shoping Cart
    Click Element    xpath://*[@id="main"]/ul/li[1]/a[2]

Check Product Exist In The Shopping Cart
    Wait Until Element Is Visible    xpath://*[@id="main"]/ul/li[1]/a[3]
    Click Element   xpath://*[@id="main"]/ul/li[1]/a[3]
    Page Should Contain    Egipt - El Gouna

Input Unlimited Promo Codes
    Input Text    id:coupon_code    ${PC_250}
    Apply Voucher
    Sleep    2
    Input Text    id:coupon_code    ${PC_10%}
    Apply Voucher

Apply Voucher
    Click Element    class:button

Sum Payable Should Be Valid
    Wait Until Element Is Visible    xpath://*[@id="post-6"]/div/div/div[2]/div/table/tbody/tr[4]/td/strong/span
    Element Should Contain    xpath://*[@id="post-6"]/div/div/div[2]/div/table/tbody/tr[4]/td/strong/span    2 810,00

Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open
    
Login Page Should Be Open
    Title Should Be    Moje konto – FakeStore

Valid Username
    Input Text    id:username    ${VALID_USER}

Valid Password
    Input Text    id:password    ${VALID_PASSWORD}

Invalid Username
    Input Text    id:username    ${INVALID_USER}

Invalid Password
    Input Text    id:password    ${INVALID_PASSWORD}

Empty Username
    Input Text    id:username    ${EMPTY}

Empty Password
    Input Text    id:password    ${EMPTY}
    
Submit Credentials
    Hide Dismiss Link Notice
    Click Element    xpath://*[@id="customer_login"]/div[1]/form/p[3]/button

Go to Login Page
    Go To    ${LOGIN_URL}
    Login Page Should Be Open

Login Should Have Failed
    Page Should Contain Element    class:woocommerce-error
