@lambda @generated
Feature: lambda - A "Lambda" "Function" Finishes Being Deleted

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
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

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
