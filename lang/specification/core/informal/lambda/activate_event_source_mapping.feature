@lambda @generated
Feature: lambda - A "Lambda" "Event Source Mapping" Finishes Creating

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @activate_event_source_mapping @internal
  Scenario: a "lambda" "event source mapping" finishes creating
    Given the "lambda" "event source mapping" existed
    And the mapping was "CREATING"
    When a "lambda" "event source mapping" finishes creating
    Then the mapping will be "ENABLED"
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @activate_event_source_mapping @internal
  Scenario: a "lambda" "event source mapping" finishes creating fails when the "lambda" "event source mapping" did not exist
    Given the "lambda" "event source mapping" did not exist
    When a "lambda" "event source mapping" finishes creating
    Then the operation is rejected

  @guard @negative @activate_event_source_mapping @internal
  Scenario: a "lambda" "event source mapping" finishes creating fails when the mapping was not "CREATING"
    Given the "lambda" "event source mapping" existed
    And the mapping was not "CREATING"
    When a "lambda" "event source mapping" finishes creating
    Then the operation is rejected
