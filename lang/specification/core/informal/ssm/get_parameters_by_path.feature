@ssm @generated
Feature: Ssm - Parameters Under A Path Are Retrieved From Ssm

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @get_parameters_by_path
  Scenario: parameters under a path are retrieved from "SSM"
    When parameters under a path are retrieved from "SSM"
    Then the parameters under the path are returned
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries
