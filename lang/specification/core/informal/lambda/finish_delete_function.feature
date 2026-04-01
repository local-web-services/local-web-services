@lambda @generated
Feature: Lambda - A "Lambda" "Function" Finishes Being Deleted

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @finish_delete_function @internal
  Scenario: a "lambda" "function" finishes being deleted
    Given the "lambda" "function" existed
    And the "lambda" "function" was "DELETING"
    When a "lambda" "function" finishes being deleted
    Then the "lambda" "function" will be "DELETED"
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

  @guard @negative @finish_delete_function @internal
  Scenario: a "lambda" "function" finishes being deleted fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a "lambda" "function" finishes being deleted
    Then the operation is rejected

  @guard @negative @finish_delete_function @internal
  Scenario: a "lambda" "function" finishes being deleted fails when the "lambda" "function" was not "DELETING"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "DELETING"
    When a "lambda" "function" finishes being deleted
    Then the operation is rejected
