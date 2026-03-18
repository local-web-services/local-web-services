@ssm @generated
Feature: Ssm - A Parameter Is Written Without Overwrite When It Already Exists

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_no_overwrite_conflict
  Scenario: a parameter is written without overwrite when it already exists
    Given the parameter exists
    And the parameter is active
    When a parameter is written without overwrite when it already exists
    Then a ParameterAlreadyExists error is recorded
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @standard @negative @put_parameter_no_overwrite_conflict
  Scenario: a parameter is written without overwrite when it already exists fails when the parameter does not exist
    Given the parameter does not exist
    When a parameter is written without overwrite when it already exists
    Then the operation is rejected

  @standard @negative @put_parameter_no_overwrite_conflict
  Scenario: a parameter is written without overwrite when it already exists fails when the parameter is not active
    Given the parameter exists
    And the parameter is not active
    When a parameter is written without overwrite when it already exists
    Then the operation is rejected
