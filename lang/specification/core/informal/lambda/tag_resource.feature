@lambda @generated
Feature: Lambda - A Tag Is Added To A Function

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @tag_resource
  Scenario: a tag is added to a function
    Given the function exists
    And the function is not "DELETING"
    And the function is not "DELETED"
    When a tag is added to a function
    Then the function has the tag set
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @standard @negative @tag_resource
  Scenario: a tag is added to a function fails when the function does not exist
    Given the function does not exist
    When a tag is added to a function
    Then the operation is rejected

  @standard @negative @tag_resource @lifecycle
  Scenario: a tag is added to a function fails when the function is "DELETING"
    Given the function exists
    And the function is "DELETING"
    When a tag is added to a function
    Then the operation is rejected

  @standard @negative @tag_resource @lifecycle
  Scenario: a tag is added to a function fails when the function is "DELETED"
    Given the function exists
    And the function is not "DELETING"
    And the function is "DELETED"
    When a tag is added to a function
    Then the operation is rejected
