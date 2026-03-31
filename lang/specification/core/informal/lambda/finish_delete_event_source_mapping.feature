@lambda @generated
Feature: Lambda - A "Lambda" "Event Source Mapping" Finishes Being Deleted

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @finish_delete_event_source_mapping
  Scenario: a "lambda" "event source mapping" finishes being deleted
    Given the "lambda" "event source mapping" existed
    And the mapping was "DELETING"
    When a "lambda" "event source mapping" finishes being deleted
    Then the mapping will be deleted
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @finish_delete_event_source_mapping
  Scenario: a "lambda" "event source mapping" finishes being deleted fails when the "lambda" "event source mapping" did not exist
    Given the "lambda" "event source mapping" did not exist
    When a "lambda" "event source mapping" finishes being deleted
    Then the operation is rejected

  @guard @negative @finish_delete_event_source_mapping @lifecycle
  Scenario: a "lambda" "event source mapping" finishes being deleted fails when the mapping was not "DELETING"
    Given the "lambda" "event source mapping" existed
    And the mapping was not "DELETING"
    When a "lambda" "event source mapping" finishes being deleted
    Then the operation is rejected
