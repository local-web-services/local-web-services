@lambda @generated
Feature: Lambda - A "Lambda" "Function" Is Invoked Asynchronously

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @invoke_function_async
  Scenario: a "lambda" "function" is invoked asynchronously
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And an async slot is available
    When a "lambda" "function" is invoked asynchronously
    Then the event will be queued in an async slot
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @invoke_function_async
  Scenario: a "lambda" "function" is invoked asynchronously fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a "lambda" "function" is invoked asynchronously
    Then the operation is rejected

  @guard @negative @invoke_function_async @lifecycle
  Scenario: a "lambda" "function" is invoked asynchronously fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a "lambda" "function" is invoked asynchronously
    Then the operation is rejected

  @guard @negative @invoke_function_async @capacity
  Scenario: a "lambda" "function" is invoked asynchronously fails when no async slot is available
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And no async slot is available
    When a "lambda" "function" is invoked asynchronously
    Then the operation is rejected
