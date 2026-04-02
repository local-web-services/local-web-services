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
    And every "ssm" "parameter" version is a positive integer
    And every "ssm" "parameter" has a valid type (String, SecureString, or StringList)
    And "ssm" "parameter" param_exists values are always valid booleans
    And the "ssm" error log only contains "ParameterAlreadyExists" entries
