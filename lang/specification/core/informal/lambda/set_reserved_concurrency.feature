@lambda @generated
Feature: Lambda - Reserved Concurrency Is Set For A Function

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @set_reserved_concurrency
  Scenario: reserved concurrency is set for a function
    Given the function exists
    And the function is "ACTIVE"
    When reserved concurrency is set for a function
    Then the function has an unreserved, throttled, or explicit concurrency limit
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @set_reserved_concurrency
  Scenario: reserved concurrency is set for a function fails when the function does not exist
    Given the function does not exist
    When reserved concurrency is set for a function
    Then the operation is rejected

  @guard @negative @set_reserved_concurrency @lifecycle
  Scenario: reserved concurrency is set for a function fails when the function is not "ACTIVE"
    Given the function exists
    And the function is not "ACTIVE"
    When reserved concurrency is set for a function
    Then the operation is rejected
