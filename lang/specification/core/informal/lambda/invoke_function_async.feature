@lambda @generated
Feature: Lambda - A Function Is Invoked Asynchronously

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @invoke_function_async
  Scenario: a function is invoked asynchronously
    Given the function exists
    And the function is "ACTIVE"
    And an async slot is available
    When a function is invoked asynchronously
    Then the event is queued in an async slot
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @invoke_function_async
  Scenario: a function is invoked asynchronously fails when the function does not exist
    Given the function does not exist
    When a function is invoked asynchronously
    Then the operation is rejected

  @guard @negative @invoke_function_async @lifecycle
  Scenario: a function is invoked asynchronously fails when the function is not "ACTIVE"
    Given the function exists
    And the function is not "ACTIVE"
    When a function is invoked asynchronously
    Then the operation is rejected

  @guard @negative @internal @invoke_function_async @capacity
  Scenario: a function is invoked asynchronously fails when no async slot is available
    Given the function exists
    And the function is "ACTIVE"
    And no async slot is available
    When a function is invoked asynchronously
    Then the operation is rejected
