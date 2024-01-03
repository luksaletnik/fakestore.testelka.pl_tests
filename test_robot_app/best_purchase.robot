*** Settings ***
Documentation     ****A test suite containing tests related to positive scenario,
...               where user can buy a product with used all possible promo codes.
...
...               This class consist of two test cases. First one, where user can
...               input seven valid promo codes. Second one, where user can buy
...               a product with login to user account.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Login To User Account
    Open Browser To Login Page
    Valid Username
    Valid Password
    Submit Credentials
    Login Page Should Be Open

Add Product To The Shopping Cart With Login
    Go to Shop Page
    Select Product Category
    Add Product To The Shopping Cart
    Check Product Exist In The Shopping Cart

Best Purchase With All Possible Promo Codes
#    Input All Possible Promo Codes
    Input Other Promo Codes
    Order Summary Should Be Valid
    [Teardown]    Close Browser
