@lambda @generated
Feature: Lambda - A Function Is Invoked Synchronously Without A Concurrency Limit

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @invoke_function_sync
  Scenario: a function is invoked synchronously without a concurrency limit
    Given the function exists
    And the function is "ACTIVE"
    And the function has concurrency configured
    And the function has unreserved concurrency
    When a function is invoked synchronously without a concurrency limit
    Then the active execution count increases
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @invoke_function_sync
  Scenario: a function is invoked synchronously without a concurrency limit fails when the function does not exist
    Given the function does not exist
    When a function is invoked synchronously without a concurrency limit
    Then the operation is rejected

  @guard @negative @invoke_function_sync @lifecycle
  Scenario: a function is invoked synchronously without a concurrency limit fails when the function is not "ACTIVE"
    Given the function exists
    And the function is not "ACTIVE"
    When a function is invoked synchronously without a concurrency limit
    Then the operation is rejected

  @guard @negative @invoke_function_sync
  Scenario: a function is invoked synchronously without a concurrency limit fails when the function does not have concurrency configured
    Given the function exists
    And the function is "ACTIVE"
    And the function does not have concurrency configured
    When a function is invoked synchronously without a concurrency limit
    Then the operation is rejected

  @guard @negative @invoke_function_sync @capacity
  Scenario: a function is invoked synchronously without a concurrency limit fails when the function does not have unreserved concurrency
    Given the function exists
    And the function is "ACTIVE"
    And the function has concurrency configured
    And the function does not have unreserved concurrency
    When a function is invoked synchronously without a concurrency limit
    Then the operation is rejected
