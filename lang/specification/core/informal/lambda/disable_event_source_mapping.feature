@lambda @generated
Feature: Lambda - An Enabled Event Source Mapping Is Disabled

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @disable_event_source_mapping
  Scenario: an enabled event source mapping is disabled
    Given the event source mapping exists
    And the mapping is "ENABLED"
    When an enabled event source mapping is disabled
    Then the mapping is "DISABLED" and inactive
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @disable_event_source_mapping
  Scenario: an enabled event source mapping is disabled fails when the event source mapping does not exist
    Given the event source mapping does not exist
    When an enabled event source mapping is disabled
    Then the operation is rejected

  @guard @negative @disable_event_source_mapping @lifecycle
  Scenario: an enabled event source mapping is disabled fails when the mapping is not "ENABLED"
    Given the event source mapping exists
    And the mapping is not "ENABLED"
    When an enabled event source mapping is disabled
    Then the operation is rejected
