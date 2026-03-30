@lambda @generated
Feature: Lambda - A Function Finishes Being Deleted

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @finish_delete_function @internal
  Scenario: a function finishes being deleted
    Given the function exists
    And the function is "DELETING"
    When a function finishes being deleted
    Then the function is "DELETED"
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @finish_delete_function @internal
  Scenario: a function finishes being deleted fails when the function does not exist
    Given the function does not exist
    When a function finishes being deleted
    Then the operation is rejected

  @guard @negative @finish_delete_function @internal
  Scenario: a function finishes being deleted fails when the function is not "DELETING"
    Given the function exists
    And the function is not "DELETING"
    When a function finishes being deleted
    Then the operation is rejected
