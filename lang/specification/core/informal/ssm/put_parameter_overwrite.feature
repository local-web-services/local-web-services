@ssm @generated
Feature: Ssm - An Existing "Ssm" "Parameter" Value Is Updated

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_overwrite
  Scenario: an existing "ssm" "parameter" value is updated
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was "active"
    When an existing "ssm" "parameter" value is updated
    Then the "ssm" "parameter" has a new value and an incremented version
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @guard @negative @put_parameter_overwrite
  Scenario: an existing "ssm" "parameter" value is updated fails when the "ssm" "parameter" did not exist
    Given the "ssm" "parameter" did not exist
    When an existing "ssm" "parameter" value is updated
    Then the operation is rejected

  @guard @negative @put_parameter_overwrite
  Scenario: an existing "ssm" "parameter" value is updated fails when the "ssm" "parameter" was not "active"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was not "active"
    When an existing "ssm" "parameter" value is updated
    Then the operation is rejected
