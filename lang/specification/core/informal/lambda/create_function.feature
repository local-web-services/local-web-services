@lambda @generated
Feature: Lambda - A Function Is Created

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @create_function
  Scenario: a function is created
    Given the function does not already exist
    When a function is created
    Then the function is in "PENDING" state
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @create_function
  Scenario: a function is created fails when the function already exists
    Given the function already exists
    When a function is created
    Then the operation is rejected
