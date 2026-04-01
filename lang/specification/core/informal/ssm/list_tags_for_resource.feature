@ssm @generated
Feature: Ssm - Tags For A "Ssm" "Parameter" Are Listed

  # Generated from FizzBee spec: ssm.fizz
  # Safety invariants: VersionIsPositive, TypeIsValid, ParamExistsValuesValid, ErrorLogEntriesAreValid

  Background:
    Given the system is initialized

  @minimal @happy @list_tags_for_resource
  Scenario: tags for a "ssm" "parameter" are listed
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was "active"
    When tags for a "ssm" "parameter" are listed
    Then the list of "ssm" "parameter" tags will be returned
    And every "ssm" "parameter" version is a positive integer
    And every "ssm" "parameter" has a valid type (String, SecureString, or StringList)
    And "ssm" "parameter" param_exists values are always valid booleans
    And the "ssm" error log only contains "ParameterAlreadyExists" entries

  @guard @negative @list_tags_for_resource
  Scenario: tags for a "ssm" "parameter" are listed fails when the "ssm" "parameter" did not exist
    Given the "ssm" "parameter" did not exist
    When tags for a "ssm" "parameter" are listed
    Then the operation is rejected

  @guard @negative @list_tags_for_resource
  Scenario: tags for a "ssm" "parameter" are listed fails when the "ssm" "parameter" was not "active"
    Given the "ssm" "parameter" existed
    And the "ssm" "parameter" was not "active"
    When tags for a "ssm" "parameter" are listed
    Then the operation is rejected
