Feature: SSM - Delete Parameter

  Background:
    Given the ssm system is initialized

  Scenario: an existing "ssm" "parameter" is deleted
    Given the "ssm" "parameter" exists
    When a "ssm" "parameter" is deleted
    Then the "ssm" "parameter" will not exist

  Scenario: deleting a missing "ssm" "parameter" returns an error
    Given the "ssm" "parameter" does not exist
    When a "ssm" "parameter" is deleted
    Then the ssm operation is rejected
