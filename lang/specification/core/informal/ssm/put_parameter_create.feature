@ssm @generated
Feature: Ssm - A Parameter Is Stored In Ssm

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_create
  Scenario: a parameter is stored in "SSM"
    Given the parameter does not already exist or has been deleted
    When a parameter is stored in "SSM"
    Then the parameter exists with version 1
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @standard @negative @put_parameter_create
  Scenario: a parameter is stored in "SSM" fails when the parameter already exists
    Given the parameter already exists
    When a parameter is stored in "SSM"
    Then the operation is rejected
