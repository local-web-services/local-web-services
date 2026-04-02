@ssm @generated
Feature: Ssm - A "Ssm" "Parameter" Is Written Without Overwrite When It Already Exists

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_no_overwrite_conflict
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was "active"
    When a "ssm" "parameter" is written without overwrite when it already exists
    Then a "ssm" "ParameterAlreadyExists" error will be recorded
    And every "ssm" "parameter" version is a positive integer
    And every "ssm" "parameter" has a valid type (String, SecureString, or StringList)
    And "ssm" "parameter" param_exists values are always valid booleans
    And the "ssm" error log only contains "ParameterAlreadyExists" entries

  @guard @negative @put_parameter_no_overwrite_conflict
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists fails when the "ssm" "parameter" did not exist
    Given the "ssm" "parameter" did not exist
    When a "ssm" "parameter" is written without overwrite when it already exists
    Then the operation is rejected

  @guard @negative @put_parameter_no_overwrite_conflict
  Scenario: a "ssm" "parameter" is written without overwrite when it already exists fails when the "ssm" "parameter" was not "active"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was not "active"
    When a "ssm" "parameter" is written without overwrite when it already exists
    Then the operation is rejected
