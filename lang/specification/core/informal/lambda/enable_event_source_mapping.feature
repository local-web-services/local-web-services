@lambda @generated
Feature: Lambda - A Disabled Event Source Mapping Is Enabled

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @enable_event_source_mapping
  Scenario: a disabled event source mapping is enabled
    Given the event source mapping exists
    And the mapping is "DISABLED"
    When a disabled event source mapping is enabled
    Then the mapping is "ENABLED" and active
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @standard @negative @enable_event_source_mapping
  Scenario: a disabled event source mapping is enabled fails when the event source mapping does not exist
    Given the event source mapping does not exist
    When a disabled event source mapping is enabled
    Then the operation is rejected

  @standard @negative @enable_event_source_mapping @lifecycle
  Scenario: a disabled event source mapping is enabled fails when the mapping is not "DISABLED"
    Given the event source mapping exists
    And the mapping is not "DISABLED"
    When a disabled event source mapping is enabled
    Then the operation is rejected
