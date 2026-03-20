@lambda @generated
Feature: Lambda - An Event Source Mapping Is Created

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @create_event_source_mapping
  Scenario: an event source mapping is created
    Given the event source mapping does not already exist
    And the function exists
    And the function is "ACTIVE"
    When an event source mapping is created
    Then the mapping is in "CREATING" state and linked to a function
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @standard @negative @create_event_source_mapping
  Scenario: an event source mapping is created fails when the event source mapping already exists
    Given the event source mapping already exists
    When an event source mapping is created
    Then the operation is rejected

  @standard @negative @create_event_source_mapping
  Scenario: an event source mapping is created fails when the function does not exist
    Given the event source mapping does not already exist
    And the function does not exist
    When an event source mapping is created
    Then the operation is rejected

  @standard @negative @create_event_source_mapping @lifecycle
  Scenario: an event source mapping is created fails when the function is not "ACTIVE"
    Given the event source mapping does not already exist
    And the function exists
    And the function is not "ACTIVE"
    When an event source mapping is created
    Then the operation is rejected
