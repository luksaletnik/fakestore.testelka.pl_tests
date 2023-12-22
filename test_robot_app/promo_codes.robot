*** Settings ***
Documentation     ****A test suite containing tests related to positive scenario,
...               where user can buy a product with promo codes without login to
...               user account
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Buy Product With Unlimited Promo Codes
    Open Browser To Shop Page
    Select Product Category
    Add Product To The Shoping Cart

    [Teardown]    Close Browser
