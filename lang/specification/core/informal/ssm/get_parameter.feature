@ssm @generated
Feature: Ssm - A Parameter Is Retrieved From Ssm

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @get_parameter
  Scenario: a parameter is retrieved from "SSM"
    Given the parameter exists
    And the parameter is active
    When a parameter is retrieved from "SSM"
    Then the parameter value is returned
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @standard @negative @get_parameter
  Scenario: a parameter is retrieved from "SSM" fails when the parameter does not exist
    Given the parameter does not exist
    When a parameter is retrieved from "SSM"
    Then the operation is rejected

  @standard @negative @get_parameter
  Scenario: a parameter is retrieved from "SSM" fails when the parameter is not active
    Given the parameter exists
    And the parameter is not active
    When a parameter is retrieved from "SSM"
    Then the operation is rejected
