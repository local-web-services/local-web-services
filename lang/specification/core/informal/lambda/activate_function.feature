@lambda @generated
Feature: lambda - A Pending "Lambda" "Function" Resolves Its Deployment

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @activate_function @internal
  Scenario: a pending "lambda" "function" resolves its deployment
    Given the "lambda" "function" existed
    And the "lambda" "function" was "PENDING"
    When a pending "lambda" "function" resolves its deployment
    Then the "lambda" "function" becomes "ACTIVE" or "FAILED" non-deterministically
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @activate_function @internal
  Scenario: a pending "lambda" "function" resolves its deployment fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a pending "lambda" "function" resolves its deployment
    Then the operation is rejected

  @guard @negative @activate_function @internal
  Scenario: a pending "lambda" "function" resolves its deployment fails when the "lambda" "function" was not "PENDING"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "PENDING"
    When a pending "lambda" "function" resolves its deployment
    Then the operation is rejected
