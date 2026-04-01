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
    And a "lambda" "async" "slot" was "available"
    When a "lambda" "function" is invoked asynchronously
    Then the "lambda" "function" event will be queued in an "async" "slot"
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

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
  Scenario: a "lambda" "function" is invoked asynchronously fails when no "lambda" "async" "slot" was "available"
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And no "lambda" "async" "slot" was "available"
    When a "lambda" "function" is invoked asynchronously
    Then the operation is rejected
