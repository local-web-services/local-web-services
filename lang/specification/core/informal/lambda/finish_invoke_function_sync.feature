@lambda @generated
Feature: Lambda - A Synchronous Function Invocation Completes

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @finish_invoke_function_sync @internal
  Scenario: a synchronous function invocation completes
    Given the function has active execution tracking
    And the function has at least one active execution
    When a synchronous function invocation completes
    Then the active execution count decreases
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @standard @negative @finish_invoke_function_sync @internal
  Scenario: a synchronous function invocation completes fails when the function does not have active execution tracking
    Given the function does not have active execution tracking
    When a synchronous function invocation completes
    Then the operation is rejected

  @standard @negative @finish_invoke_function_sync @internal
  Scenario: a synchronous function invocation completes fails when the function has no active executions
    Given the function has active execution tracking
    And the function has no active executions
    When a synchronous function invocation completes
    Then the operation is rejected
