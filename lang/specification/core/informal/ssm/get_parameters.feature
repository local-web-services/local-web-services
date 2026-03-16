@ssm @generated
Feature: Ssm - Multiple Parameters Are Retrieved From Ssm

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @get_parameters
  Scenario: multiple parameters are retrieved from "SSM"
    When multiple parameters are retrieved from "SSM"
    Then the parameter values are returned
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries
