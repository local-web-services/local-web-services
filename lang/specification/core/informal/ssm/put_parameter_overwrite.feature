@ssm @generated
Feature: Ssm - An Existing Parameter Value Is Updated

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @put_parameter_overwrite
  Scenario: an existing parameter value is updated
    Given the parameter exists
    And the parameter is active
    When an existing parameter value is updated
    Then the parameter has a new value and an incremented version
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @guard @negative @put_parameter_overwrite
  Scenario: an existing parameter value is updated fails when the parameter does not exist
    Given the parameter does not exist
    When an existing parameter value is updated
    Then the operation is rejected

  @guard @negative @put_parameter_overwrite
  Scenario: an existing parameter value is updated fails when the parameter is not active
    Given the parameter exists
    And the parameter is not active
    When an existing parameter value is updated
    Then the operation is rejected
