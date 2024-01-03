*** Settings ***
Documentation     ****A test suite with tests for valid promo codes.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Valid Unlimited Promo Codes
    Open Browser To Shop Page
    Select Product Category
    Add Product To The Shopping Cart
    Check Product Exist In The Shopping Cart
    Input Unlimited Promo Codes
    Sleep    2
    Sum Payable Should Be Valid
    [Teardown]    Close Browser
