Feature: SSM - Get Parameter

  Background:
    Given the ssm system is initialized

  Scenario: an existing "ssm" "parameter" is retrieved
    Given the "ssm" "parameter" exists
    When a "ssm" "parameter" is retrieved
    Then the "ssm" "parameter" value will be returned

  Scenario: a missing "ssm" "parameter" returns an error
    Given the "ssm" "parameter" does not exist
    When a "ssm" "parameter" is retrieved
    Then the ssm operation is rejected
