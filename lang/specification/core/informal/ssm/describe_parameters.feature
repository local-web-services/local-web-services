@ssm @generated
Feature: Ssm - "Ssm" "Parameter"S Are Described

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @describe_parameters
  Scenario: "ssm" "parameter"s are described
    When "ssm" "parameter"s are described
    Then the "ssm" "parameter" metadata will be returned
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries
