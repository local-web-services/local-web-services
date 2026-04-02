@lambda @generated
Feature: Lambda - A Disabled "Lambda" "Event Source Mapping" Is Deleted

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @delete_disabled_event_source_mapping
  Scenario: a disabled "lambda" "event source mapping" is deleted
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was "DISABLED"
    When a disabled "lambda" "event source mapping" is deleted
    Then the "lambda" "event source mapping" will be in "DELETING" state
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

  @guard @negative @delete_disabled_event_source_mapping
  Scenario: a disabled "lambda" "event source mapping" is deleted fails when the "lambda" "event source mapping" did not exist
    Given the "lambda" "event source mapping" did not exist
    When a disabled "lambda" "event source mapping" is deleted
    Then the operation is rejected

  @guard @negative @delete_disabled_event_source_mapping @lifecycle
  Scenario: a disabled "lambda" "event source mapping" is deleted fails when the "lambda" "event source mapping" was not "DISABLED"
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was not "DISABLED"
    When a disabled "lambda" "event source mapping" is deleted
    Then the operation is rejected
