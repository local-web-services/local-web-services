@lambda @generated
Feature: Lambda - A Synchronous "Lambda" "Function" Invocation Completes

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @finish_invoke_function_sync @internal
  Scenario: a synchronous "lambda" "function" invocation completes
    Given the "lambda" "function" had active execution tracking
    And the "lambda" "function" had at least one active execution
    When a synchronous "lambda" "function" invocation completes
    Then the "lambda" "function" active execution count will decrease
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

  @guard @negative @finish_invoke_function_sync @internal
  Scenario: a synchronous "lambda" "function" invocation completes fails when the "lambda" "function" did not have active execution tracking
    Given the "lambda" "function" did not have active execution tracking
    When a synchronous "lambda" "function" invocation completes
    Then the operation is rejected

  @guard @negative @finish_invoke_function_sync @internal
  Scenario: a synchronous "lambda" "function" invocation completes fails when the "lambda" "function" had no active executions
    Given the "lambda" "function" had active execution tracking
    And the "lambda" "function" had no active executions
    When a synchronous "lambda" "function" invocation completes
    Then the operation is rejected
