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
