Feature: Lambda - Function Management

  Background:
    Given the lambda system is initialized

  Scenario: a "lambda" "function" is created
    Given the "lambda" "function" did not already exist
    When a "lambda" "function" is created
    Then the "lambda" "function" will exist

  Scenario: a "lambda" "function" is deleted
    Given a "lambda" "function" existed
    When a "lambda" "function" is deleted
    Then the "lambda" "function" will not exist

  Scenario: a "lambda" "function" is invoked
    Given a "lambda" "function" existed
    When a "lambda" "function" is invoked
    Then the invocation will succeed
