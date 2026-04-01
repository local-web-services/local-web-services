@lambda @generated
Feature: lambda - A Permission Is Removed From A "Lambda" "Function"'S Resource Policy

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @remove_permission
  Scenario: a permission is removed from a "lambda" "function"'s resource policy
    Given the "lambda" "function" had a resource policy entry
    And the "lambda" "function" had a resource policy
    When a permission is removed from a "lambda" "function"'s resource policy
    Then the "lambda" "function"'s resource policy will be cleared
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @remove_permission
  Scenario: a permission is removed from a "lambda" "function"'s resource policy fails when the "lambda" "function" did not have a resource policy entry
    Given the "lambda" "function" did not have a resource policy entry
    When a permission is removed from a "lambda" "function"'s resource policy
    Then the operation is rejected

  @guard @negative @remove_permission
  Scenario: a permission is removed from a "lambda" "function"'s resource policy fails when the "lambda" "function" did not have a resource policy
    Given the "lambda" "function" had a resource policy entry
    And the "lambda" "function" did not have a resource policy
    When a permission is removed from a "lambda" "function"'s resource policy
    Then the operation is rejected
