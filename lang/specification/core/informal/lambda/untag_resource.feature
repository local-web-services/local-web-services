@lambda @generated
Feature: Lambda - A Tag Is Removed From A Function

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @untag_resource
  Scenario: a tag is removed from a function
    Given the function exists
    And the tag exists on the function
    And the tag is set
    When a tag is removed from a function
    Then the tag is cleared from the function
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @untag_resource
  Scenario: a tag is removed from a function fails when the function does not exist
    Given the function does not exist
    When a tag is removed from a function
    Then the operation is rejected

  @guard @negative @untag_resource
  Scenario: a tag is removed from a function fails when the tag does not exist on the function
    Given the function exists
    And the tag does not exist on the function
    When a tag is removed from a function
    Then the operation is rejected

  @guard @negative @untag_resource
  Scenario: a tag is removed from a function fails when the tag is not set
    Given the function exists
    And the tag exists on the function
    And the tag is not set
    When a tag is removed from a function
    Then the operation is rejected
