@lambda @generated
Feature: Lambda - A "Lambda" "Event Source Mapping" Finishes Creating

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @activate_event_source_mapping @internal
  Scenario: a "lambda" "event source mapping" finishes creating
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was "CREATING"
    When a "lambda" "event source mapping" finishes creating
    Then the "lambda" "event source mapping" will be "ENABLED"
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

  @guard @negative @activate_event_source_mapping @internal
  Scenario: a "lambda" "event source mapping" finishes creating fails when the "lambda" "event source mapping" did not exist
    Given the "lambda" "event source mapping" did not exist
    When a "lambda" "event source mapping" finishes creating
    Then the operation is rejected

  @guard @negative @activate_event_source_mapping @internal
  Scenario: a "lambda" "event source mapping" finishes creating fails when the "lambda" "event source mapping" was not "CREATING"
    Given the "lambda" "event source mapping" existed
    And the "lambda" "event source mapping" was not "CREATING"
    When a "lambda" "event source mapping" finishes creating
    Then the operation is rejected
