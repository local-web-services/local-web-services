@lambda @generated
Feature: Lambda - A "Lambda" "Event Source Mapping" Finishes Being Deleted

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @finish_delete_event_source_mapping
  Scenario: a "lambda" "event source mapping" finishes being deleted
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was "DELETING"
    When a "lambda" "event source mapping" finishes being deleted
    Then the "lambda" "event source mapping" will be deleted
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

  @guard @negative @finish_delete_event_source_mapping
  Scenario: a "lambda" "event source mapping" finishes being deleted fails when the "lambda" "event source mapping" did not exist
    Given the "lambda" "event source mapping" did not exist
    When a "lambda" "event source mapping" finishes being deleted
    Then the operation is rejected

  @guard @negative @finish_delete_event_source_mapping @lifecycle
  Scenario: a "lambda" "event source mapping" finishes being deleted fails when the "lambda" "event source mapping" was not "DELETING"
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was not "DELETING"
    When a "lambda" "event source mapping" finishes being deleted
    Then the operation is rejected
