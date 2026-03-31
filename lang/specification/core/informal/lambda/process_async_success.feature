@lambda @generated
Feature: Lambda - An Async Invocation Succeeds

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @process_async_success @internal
  Scenario: an async invocation succeeds
    Given the async slot is occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When an async invocation succeeds
    Then the async slot will be freed
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @process_async_success @internal
  Scenario: an async invocation succeeds fails when the async slot was empty
    Given the async slot was empty
    When an async invocation succeeds
    Then the operation is rejected

  @guard @negative @process_async_success @internal
  Scenario: an async invocation succeeds fails when the async slot does not have a "lambda" "function" assigned
    Given the async slot is occupied
    And the async slot does not have a "lambda" "function" assigned
    When an async invocation succeeds
    Then the operation is rejected

  @guard @negative @process_async_success @internal
  Scenario: an async invocation succeeds fails when the "lambda" "function" did not exist
    Given the async slot is occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" did not exist
    When an async invocation succeeds
    Then the operation is rejected

  @guard @negative @process_async_success @internal
  Scenario: an async invocation succeeds fails when the "lambda" "function" was not "ACTIVE"
    Given the async slot is occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When an async invocation succeeds
    Then the operation is rejected
