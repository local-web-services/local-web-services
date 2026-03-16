@lambda @generated
Feature: Lambda - An Active Function Is Deleted

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @delete_function
  Scenario: an active function is deleted
    Given the function exists
    And the function is "ACTIVE"
    And the function has no active executions
    When an active function is deleted
    Then the function enters "DELETING" state
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @standard @negative @delete_function
  Scenario: an active function is deleted fails when the function does not exist
    Given the function does not exist
    When an active function is deleted
    Then the operation is rejected

  @standard @negative @delete_function @lifecycle
  Scenario: an active function is deleted fails when the function is not "ACTIVE"
    Given the function exists
    And the function is not "ACTIVE"
    When an active function is deleted
    Then the operation is rejected

  @standard @negative @delete_function
  Scenario: an active function is deleted fails when the function has active executions
    Given the function exists
    And the function is "ACTIVE"
    And the function has active executions
    When an active function is deleted
    Then the operation is rejected
