@ssm @generated
Feature: Ssm - Tags Are Removed From A "Ssm" "Parameter"

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @remove_tags_from_resource
  Scenario: tags are removed from a "ssm" "parameter"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was "active"
    And the tag was associated with the "ssm" "parameter"
    And the tag association was "ACTIVE"
    When tags are removed from a "ssm" "parameter"
    Then the tags are disassociated from the "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @guard @negative @remove_tags_from_resource
  Scenario: tags are removed from a "ssm" "parameter" fails when the "ssm" "parameter" did not exist
    Given the "ssm" "parameter" did not exist
    When tags are removed from a "ssm" "parameter"
    Then the operation is rejected

  @guard @negative @remove_tags_from_resource
  Scenario: tags are removed from a "ssm" "parameter" fails when the "ssm" "parameter" was not "active"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was not "active"
    When tags are removed from a "ssm" "parameter"
    Then the operation is rejected

  @guard @negative @remove_tags_from_resource
  Scenario: tags are removed from a "ssm" "parameter" fails when the tag was not associated with the "ssm" "parameter"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was "active"
    And the tag was not associated with the "ssm" "parameter"
    When tags are removed from a "ssm" "parameter"
    Then the operation is rejected

  @guard @negative @remove_tags_from_resource
  Scenario: tags are removed from a "ssm" "parameter" fails when the tag association was not "ACTIVE"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was "active"
    And the tag was associated with the "ssm" "parameter"
    And the tag association was not "ACTIVE"
    When tags are removed from a "ssm" "parameter"
    Then the operation is rejected
