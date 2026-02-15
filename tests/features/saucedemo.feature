Feature: SauceDemo E2E Shopping Flow
  As a user of SauceDemo
  I want to add products to cart and complete checkout
  So that I can purchase items successfully

  @smoke @critical
  Scenario: Happy Path - Complete purchase flow
    Given I am on the SauceDemo login page
    When I login with username "standard_user" and password "secret_sauce"
    Then I should be redirected to the inventory page
    When I add "Sauce Labs Backpack" to the cart
    And I go to the cart
    And I proceed to checkout
    And I fill checkout information with firstName "John", lastName "Doe", and postalCode "12345"
    And I finish the checkout
    Then I should see the confirmation message "Thank you for your order!"

  @negative @regression
  Scenario: Login Failed - Locked out user
    Given I am on the SauceDemo login page
    When I login with username "locked_out_user" and password "secret_sauce"
    Then I should see the error message "Epic sadface: Sorry, this user has been locked out."

  @regression
  Scenario Outline: Data Driven - Multiple users login and add to cart
    Given I am on the SauceDemo login page
    When I login with username "<username>" and password "secret_sauce"
    Then I should be redirected to the inventory page
    When I add "Sauce Labs Bike Light" to the cart
    Then the cart badge should show <itemCount> item

    Examples:
      | username                | itemCount |
      | standard_user           | 1         |
      | problem_user            | 1         |
      | performance_glitch_user | 1         |
