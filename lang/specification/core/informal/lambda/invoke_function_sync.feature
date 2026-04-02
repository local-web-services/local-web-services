@lambda @generated
Feature: Lambda - A "Lambda" "Function" Is Invoked Synchronously Without A Concurrency Limit

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @invoke_function_sync
  Scenario: a "lambda" "function" is invoked synchronously without a concurrency limit
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "function" had concurrency configured
    And the "lambda" "function" had unreserved concurrency
    When a "lambda" "function" is invoked synchronously without a concurrency limit
    Then the "lambda" "function" active execution count will increase
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

  @guard @negative @invoke_function_sync
  Scenario: a "lambda" "function" is invoked synchronously without a concurrency limit fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a "lambda" "function" is invoked synchronously without a concurrency limit
    Then the operation is rejected

  @guard @negative @invoke_function_sync @lifecycle
  Scenario: a "lambda" "function" is invoked synchronously without a concurrency limit fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a "lambda" "function" is invoked synchronously without a concurrency limit
    Then the operation is rejected

  @guard @negative @invoke_function_sync
  Scenario: a "lambda" "function" is invoked synchronously without a concurrency limit fails when the "lambda" "function" did not have concurrency configured
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "function" did not have concurrency configured
    When a "lambda" "function" is invoked synchronously without a concurrency limit
    Then the operation is rejected

  @guard @negative @invoke_function_sync @capacity
  Scenario: a "lambda" "function" is invoked synchronously without a concurrency limit fails when the "lambda" "function" did not have unreserved concurrency
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And the "lambda" "function" had concurrency configured
    And the "lambda" "function" did not have unreserved concurrency
    When a "lambda" "function" is invoked synchronously without a concurrency limit
    Then the operation is rejected
