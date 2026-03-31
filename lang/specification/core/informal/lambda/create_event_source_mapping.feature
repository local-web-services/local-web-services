@lambda @generated
Feature: lambda - A "Lambda" Event Source Mapping Is Created

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @create_event_source_mapping
  Scenario: a "lambda" event source mapping is created
    Given the "lambda" "event source mapping" did not already exist
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When a "lambda" event source mapping is created
    Then the mapping will be in "CREATING" state and linked to a "lambda" "function"
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @create_event_source_mapping
  Scenario: a "lambda" event source mapping is created fails when the "lambda" "event source mapping" already existed
    Given the "lambda" "event source mapping" already existed
    When a "lambda" event source mapping is created
    Then the operation is rejected

  @guard @negative @create_event_source_mapping
  Scenario: a "lambda" event source mapping is created fails when the "lambda" "function" did not exist
    Given the "lambda" "event source mapping" did not already exist
    And the "lambda" "function" did not exist
    When a "lambda" event source mapping is created
    Then the operation is rejected

  @guard @negative @create_event_source_mapping @lifecycle
  Scenario: a "lambda" event source mapping is created fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "event source mapping" did not already exist
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a "lambda" event source mapping is created
    Then the operation is rejected
