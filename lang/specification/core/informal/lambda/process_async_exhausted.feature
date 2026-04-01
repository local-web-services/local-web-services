@lambda @generated
Feature: Lambda - A "Lambda" "Async" Invocation Exhausts All Retries

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @process_async_exhausted @internal
  Scenario: a "lambda" "async" invocation exhausts all retries
    Given the "lambda" "async" "slot" was occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And "lambda" "async" "slot" retry tracking was available
    And the "lambda" "function" async retry count had been exhausted
    When a "lambda" "async" invocation exhausts all retries
    Then the "lambda" "function" async event will be dropped and the "async" "slot" will be freed
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

  @guard @negative @process_async_exhausted @internal
  Scenario: a "lambda" "async" invocation exhausts all retries fails when the "lambda" "async" "slot" was empty
    Given the "lambda" "async" "slot" was empty
    When a "lambda" "async" invocation exhausts all retries
    Then the operation is rejected

  @guard @negative @process_async_exhausted @internal
  Scenario: a "lambda" "async" invocation exhausts all retries fails when the async slot does not have a "lambda" "function" assigned
    Given the "lambda" "async" "slot" was occupied
    And the async slot does not have a "lambda" "function" assigned
    When a "lambda" "async" invocation exhausts all retries
    Then the operation is rejected

  @guard @negative @process_async_exhausted @internal
  Scenario: a "lambda" "async" invocation exhausts all retries fails when the "lambda" "function" did not exist
    Given the "lambda" "async" "slot" was occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" did not exist
    When a "lambda" "async" invocation exhausts all retries
    Then the operation is rejected

  @guard @negative @process_async_exhausted @internal
  Scenario: a "lambda" "async" invocation exhausts all retries fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "async" "slot" was occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a "lambda" "async" invocation exhausts all retries
    Then the operation is rejected

  @guard @negative @process_async_exhausted @internal
  Scenario: a "lambda" "async" invocation exhausts all retries fails when "lambda" "async" "slot" retry tracking was not available
    Given the "lambda" "async" "slot" was occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And "lambda" "async" "slot" retry tracking was not available
    When a "lambda" "async" invocation exhausts all retries
    Then the operation is rejected

  @guard @negative @process_async_exhausted @internal
  Scenario: a "lambda" "async" invocation exhausts all retries fails when the "lambda" "function" async retry count had not been exhausted
    Given the "lambda" "async" "slot" was occupied
    And the async slot has a "lambda" "function" assigned
    And the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    And "lambda" "async" "slot" retry tracking was available
    And the "lambda" "function" async retry count had not been exhausted
    When a "lambda" "async" invocation exhausts all retries
    Then the operation is rejected
