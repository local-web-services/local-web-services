@ssm @generated
Feature: Ssm - Tags For A Parameter Are Listed

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @list_tags_for_resource
  Scenario: tags for a parameter are listed
    Given the parameter exists
    And the parameter is active
    When tags for a parameter are listed
    Then the list of tags is returned
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @standard @negative @list_tags_for_resource
  Scenario: tags for a parameter are listed fails when the parameter does not exist
    Given the parameter does not exist
    When tags for a parameter are listed
    Then the operation is rejected

  @standard @negative @list_tags_for_resource
  Scenario: tags for a parameter are listed fails when the parameter is not active
    Given the parameter exists
    And the parameter is not active
    When tags for a parameter are listed
    Then the operation is rejected
