*** Settings ***
Documentation     ****A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${URL}           https://fakestore.testelka.pl/
${BROWSER}       chrome
${DELAY}         0
${VALID_USER}    tester.21633
${VALID_PASSWORD}    test_demo_21633
${LOGIN_URL}     https://fakestore.testelka.pl/moje-konto/

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open
    
Login Page Should Be Open
    Title Should Be    Moje konto – FakeStore

Input Username
    Input Text    id:username    ${VALID_USER}

# SeleniumLibrary already contains a keyword: Input Password
# Keyword Input Password used in valid_login.robot Test Case
#Input Password
#    [Arguments]    ${VALID_PASSWORD}
#    Input Text    id:password    ${VALID_PASSWORD}
    
Submit Credentials
    Click Element    xpath:/html/body/p/a
    Click Element    xpath://*[@id="customer_login"]/div[1]/form/p[3]/button
    
Welcome Page Should Be Open
    Location Should Be    ${LOGIN_URL}
    Title Should Be    Moje konto – FakeStore
