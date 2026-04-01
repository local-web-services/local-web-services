@ssm @generated
Feature: Ssm - Tags Are Added To A "Ssm" "Parameter"

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @add_tags_to_resource
  Scenario: tags are added to a "ssm" "parameter"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was "active"
    When tags are added to a "ssm" "parameter"
    Then the tags are associated with the "ssm" "parameter"
    And every parameter version is a positive integer
    And every parameter has a valid type (String, SecureString, or StringList)
    And param_exists values are always valid booleans
    And the error log only contains ParameterAlreadyExists entries

  @guard @negative @add_tags_to_resource
  Scenario: tags are added to a "ssm" "parameter" fails when the "ssm" "parameter" did not exist
    Given the "ssm" "parameter" did not exist
    When tags are added to a "ssm" "parameter"
    Then the operation is rejected

  @guard @negative @add_tags_to_resource
  Scenario: tags are added to a "ssm" "parameter" fails when the "ssm" "parameter" was not "active"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was not "active"
    When tags are added to a "ssm" "parameter"
    Then the operation is rejected
