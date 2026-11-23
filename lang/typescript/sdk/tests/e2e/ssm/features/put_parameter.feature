Feature: SSM - Put Parameter

  Background:
    Given the ssm system is initialized

  Scenario: a "ssm" "parameter" is stored
    When a "ssm" "parameter" is stored
    Then the "ssm" "parameter" will exist
