@lambda @generated
Feature: lambda - A Permission Is Added To A "Lambda" "Function"'S Resource Policy

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @add_permission
  Scenario: a permission is added to a "lambda" "function"'s resource policy
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When a permission is added to a "lambda" "function"'s resource policy
    Then the "lambda" "function" has a resource policy
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @add_permission
  Scenario: a permission is added to a "lambda" "function"'s resource policy fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a permission is added to a "lambda" "function"'s resource policy
    Then the operation is rejected

  @guard @negative @add_permission @lifecycle
  Scenario: a permission is added to a "lambda" "function"'s resource policy fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a permission is added to a "lambda" "function"'s resource policy
    Then the operation is rejected
