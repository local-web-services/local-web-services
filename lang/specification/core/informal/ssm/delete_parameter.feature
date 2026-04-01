@ssm @generated
Feature: Ssm - A "Ssm" "Parameter" Is Deleted

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @delete_parameter
  Scenario: a "ssm" "parameter" is deleted
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was "active"
    When a "ssm" "parameter" is deleted
    Then the "ssm" "parameter" no longer will exist
    And every "ssm" "parameter" version is a positive integer
    And every "ssm" "parameter" has a valid type (String, SecureString, or StringList)
    And "ssm" "parameter" param_exists values are always valid booleans
    And the "ssm" error log only contains "ParameterAlreadyExists" entries

  @guard @negative @delete_parameter
  Scenario: a "ssm" "parameter" is deleted fails when the "ssm" "parameter" did not exist
    Given the "ssm" "parameter" did not exist
    When a "ssm" "parameter" is deleted
    Then the operation is rejected

  @guard @negative @delete_parameter
  Scenario: a "ssm" "parameter" is deleted fails when the "ssm" "parameter" was not "active"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was not "active"
    When a "ssm" "parameter" is deleted
    Then the operation is rejected
