@ssm @generated
Feature: Ssm - Multiple Parameters Are Deleted From Ssm

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @delete_parameters
  Scenario: multiple parameters are deleted from "SSM"
    Given the parameter exists
    And the parameter is active
    When multiple parameters are deleted from "SSM"
    Then the parameters no longer exist
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @guard @negative @delete_parameters
  Scenario: multiple parameters are deleted from "SSM" fails when the parameter does not exist
    Given the parameter does not exist
    When multiple parameters are deleted from "SSM"
    Then the operation is rejected

  @guard @negative @delete_parameters
  Scenario: multiple parameters are deleted from "SSM" fails when the parameter is not active
    Given the parameter exists
    And the parameter is not active
    When multiple parameters are deleted from "SSM"
    Then the operation is rejected
