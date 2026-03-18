@lambda @generated
Feature: Lambda - A Permission Is Added To A Function'S Resource Policy

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @add_permission
  Scenario: a permission is added to a function's resource policy
    Given the function exists
    And the function is "ACTIVE"
    When a permission is added to a function's resource policy
    Then the function has a resource policy
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @standard @negative @add_permission
  Scenario: a permission is added to a function's resource policy fails when the function does not exist
    Given the function does not exist
    When a permission is added to a function's resource policy
    Then the operation is rejected

  @standard @negative @add_permission @lifecycle @internal
  Scenario: a permission is added to a function's resource policy fails when the function is not "ACTIVE"
    Given the function exists
    And the function is not "ACTIVE"
    When a permission is added to a function's resource policy
    Then the operation is rejected
