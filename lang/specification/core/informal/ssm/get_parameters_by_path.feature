@ssm @generated
Feature: Ssm - "Ssm" "Parameter"S Under A Path Are Retrieved

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @get_parameters_by_path
  Scenario: "ssm" "parameter"s under a path are retrieved
    When "ssm" "parameter"s under a path are retrieved
    Then the "ssm" "parameter"s under the path will be returned
    And every "ssm" "parameter" version is a positive integer
    And every "ssm" "parameter" has a valid type (String, SecureString, or StringList)
    And "ssm" "parameter" param_exists values are always valid booleans
    And the "ssm" error log only contains "ParameterAlreadyExists" entries
