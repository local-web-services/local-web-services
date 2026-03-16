@lambda @generated
Feature: Lambda - A Permission Is Removed From A Function'S Resource Policy

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @remove_permission
  Scenario: a permission is removed from a function's resource policy
    Given the function has a resource policy entry
    And the function has a resource policy
    When a permission is removed from a function's resource policy
    Then the function's resource policy is cleared
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @standard @negative @remove_permission
  Scenario: a permission is removed from a function's resource policy fails when the function does not have a resource policy entry
    Given the function does not have a resource policy entry
    When a permission is removed from a function's resource policy
    Then the operation is rejected

  @standard @negative @remove_permission
  Scenario: a permission is removed from a function's resource policy fails when the function does not have a resource policy
    Given the function has a resource policy entry
    And the function does not have a resource policy
    When a permission is removed from a function's resource policy
    Then the operation is rejected
