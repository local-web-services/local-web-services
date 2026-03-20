@lambda @generated
Feature: Lambda - An Event Source Mapping Finishes Being Deleted

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @finish_delete_event_source_mapping
  Scenario: an event source mapping finishes being deleted
    Given the event source mapping exists
    And the mapping is "DELETING"
    When an event source mapping finishes being deleted
    Then the mapping is "DELETED"
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @standard @negative @finish_delete_event_source_mapping
  Scenario: an event source mapping finishes being deleted fails when the event source mapping does not exist
    Given the event source mapping does not exist
    When an event source mapping finishes being deleted
    Then the operation is rejected

  @standard @negative @finish_delete_event_source_mapping @lifecycle
  Scenario: an event source mapping finishes being deleted fails when the mapping is not "DELETING"
    Given the event source mapping exists
    And the mapping is not "DELETING"
    When an event source mapping finishes being deleted
    Then the operation is rejected
