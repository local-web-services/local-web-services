@ssm @generated
Feature: Ssm - A "Ssm" "Parameter" Is Retrieved

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @get_parameter
  Scenario: a "ssm" "parameter" is retrieved
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was "active"
    When a "ssm" "parameter" is retrieved
    Then the "ssm" "parameter" value will be returned
    And every "ssm" "parameter" version is a positive integer
    And every "ssm" "parameter" has a valid type (String, SecureString, or StringList)
    And "ssm" "parameter" param_exists values are always valid booleans
    And the "ssm" error log only contains "ParameterAlreadyExists" entries

  @guard @negative @get_parameter
  Scenario: a "ssm" "parameter" is retrieved fails when the "ssm" "parameter" did not exist
    Given the "ssm" "parameter" did not exist
    When a "ssm" "parameter" is retrieved
    Then the operation is rejected

  @guard @negative @get_parameter
  Scenario: a "ssm" "parameter" is retrieved fails when the "ssm" "parameter" was not "active"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was not "active"
    When a "ssm" "parameter" is retrieved
    Then the operation is rejected
