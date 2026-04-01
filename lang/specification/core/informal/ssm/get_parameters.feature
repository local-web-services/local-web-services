@ssm @generated
Feature: Ssm - Multiple "Ssm" "Parameter"S Are Retrieved

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @get_parameters
  Scenario: multiple "ssm" "parameter"s are retrieved
    When multiple "ssm" "parameter"s are retrieved
    Then the "ssm" "parameter" values will be returned
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries
