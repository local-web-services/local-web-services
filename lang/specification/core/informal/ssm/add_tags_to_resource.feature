@ssm @generated
Feature: Ssm - Tags Are Added To A Parameter

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @add_tags_to_resource
  Scenario: tags are added to a parameter
    Given the parameter exists
    And the parameter is active
    When tags are added to a parameter
    Then the tags are associated with the parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @standard @negative @add_tags_to_resource
  Scenario: tags are added to a parameter fails when the parameter does not exist
    Given the parameter does not exist
    When tags are added to a parameter
    Then the operation is rejected

  @standard @negative @add_tags_to_resource
  Scenario: tags are added to a parameter fails when the parameter is not active
    Given the parameter exists
    And the parameter is not active
    When tags are added to a parameter
    Then the operation is rejected
