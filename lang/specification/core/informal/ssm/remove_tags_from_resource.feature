@ssm @generated
Feature: Ssm - Tags Are Removed From A Parameter

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @remove_tags_from_resource
  Scenario: tags are removed from a parameter
    Given the parameter exists
    And the parameter is active
    And the tag is associated with the parameter
    And the tag association is active
    When tags are removed from a parameter
    Then the tags are disassociated from the parameter
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @standard @negative @remove_tags_from_resource
  Scenario: tags are removed from a parameter fails when the parameter does not exist
    Given the parameter does not exist
    When tags are removed from a parameter
    Then the operation is rejected

  @standard @negative @remove_tags_from_resource
  Scenario: tags are removed from a parameter fails when the parameter is not active
    Given the parameter exists
    And the parameter is not active
    When tags are removed from a parameter
    Then the operation is rejected

  @standard @negative @remove_tags_from_resource
  Scenario: tags are removed from a parameter fails when the tag is not associated with the parameter
    Given the parameter exists
    And the parameter is active
    And the tag is not associated with the parameter
    When tags are removed from a parameter
    Then the operation is rejected

  @standard @negative @remove_tags_from_resource
  Scenario: tags are removed from a parameter fails when the tag association is not active
    Given the parameter exists
    And the parameter is active
    And the tag is associated with the parameter
    And the tag association is not active
    When tags are removed from a parameter
    Then the operation is rejected
