@lambda @generated
Feature: Lambda - A Pending "Lambda" "Function" Resolves Its Deployment

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
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

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
