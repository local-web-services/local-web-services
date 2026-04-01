@ssm @generated
Feature: Ssm - A "Ssm" "Parameter" Is Stored

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_create
  Scenario: a "ssm" "parameter" is stored
    Given the "ssm" "parameter" did not already exist or has been deleted
    When a "ssm" "parameter" is stored
    Then the "ssm" "parameter" will exist with version 1
    And every "ssm" "parameter" version is a positive integer
    And every "ssm" "parameter" has a valid type (String, SecureString, or StringList)
    And "ssm" "parameter" param_exists values are always valid booleans
    And the "ssm" error log only contains "ParameterAlreadyExists" entries

  @guard @negative @put_parameter_create
  Scenario: a "ssm" "parameter" is stored fails when the "ssm" "parameter" already existed
    Given the "ssm" "parameter" already existed
    When a "ssm" "parameter" is stored
    Then the operation is rejected
