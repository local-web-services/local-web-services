@lambda @generated
Feature: Lambda - A Function'S Code Is Updated

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @update_function_code
  Scenario: a function's code is updated
    Given the function exists
    And the function is "ACTIVE"
    When a function's code is updated
    Then the function returns to "PENDING" state for redeployment
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @standard @negative @update_function_code
  Scenario: a function's code is updated fails when the function does not exist
    Given the function does not exist
    When a function's code is updated
    Then the operation is rejected

  @standard @negative @update_function_code @lifecycle @internal
  Scenario: a function's code is updated fails when the function is not "ACTIVE"
    Given the function exists
    And the function is not "ACTIVE"
    When a function's code is updated
    Then the operation is rejected
