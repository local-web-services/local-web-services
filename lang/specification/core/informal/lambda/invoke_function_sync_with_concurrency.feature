@lambda @generated
Feature: Lambda - A "Lambda" "Function" Is Invoked Synchronously Within Its Concurrency Limit

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @invoke_function_sync_with_concurrency
  Scenario: a "lambda" "function" is invoked synchronously within its concurrency limit
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "function" had concurrency configured
    And the "lambda" "function" had a positive concurrency limit
    And the "lambda" "function" had active executions tracked
    And the active executions were below the concurrency limit
    When a "lambda" "function" is invoked synchronously within its concurrency limit
    Then the active execution count increases
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @invoke_function_sync_with_concurrency
  Scenario: a "lambda" "function" is invoked synchronously within its concurrency limit fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a "lambda" "function" is invoked synchronously within its concurrency limit
    Then the operation is rejected

  @guard @negative @invoke_function_sync_with_concurrency @lifecycle
  Scenario: a "lambda" "function" is invoked synchronously within its concurrency limit fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a "lambda" "function" is invoked synchronously within its concurrency limit
    Then the operation is rejected

  @guard @negative @invoke_function_sync_with_concurrency
  Scenario: a "lambda" "function" is invoked synchronously within its concurrency limit fails when the "lambda" "function" did not have concurrency configured
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "function" did not have concurrency configured
    When a "lambda" "function" is invoked synchronously within its concurrency limit
    Then the operation is rejected

  @guard @negative @invoke_function_sync_with_concurrency @capacity
  Scenario: a "lambda" "function" is invoked synchronously within its concurrency limit fails when the "lambda" "function" did not have a positive concurrency limit
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "function" had concurrency configured
    And the "lambda" "function" did not have a positive concurrency limit
    When a "lambda" "function" is invoked synchronously within its concurrency limit
    Then the operation is rejected

  @guard @negative @invoke_function_sync_with_concurrency
  Scenario: a "lambda" "function" is invoked synchronously within its concurrency limit fails when the "lambda" "function" does not have active executions tracked
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "function" had concurrency configured
    And the "lambda" "function" had a positive concurrency limit
    And the "lambda" "function" does not have active executions tracked
    When a "lambda" "function" is invoked synchronously within its concurrency limit
    Then the operation is rejected

  @guard @negative @invoke_function_sync_with_concurrency @capacity
  Scenario: a "lambda" "function" is invoked synchronously within its concurrency limit fails when the active executions were at or above the concurrency limit
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "function" had concurrency configured
    And the "lambda" "function" had a positive concurrency limit
    And the "lambda" "function" had active executions tracked
    And the active executions were at or above the concurrency limit
    When a "lambda" "function" is invoked synchronously within its concurrency limit
    Then the operation is rejected
