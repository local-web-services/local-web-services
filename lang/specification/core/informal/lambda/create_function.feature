@lambda @generated
Feature: Lambda - A "Lambda" "Function" Is Created

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @create_function
  Scenario: a "lambda" "function" is created
    Given the "lambda" "function" did not already exist
    When a "lambda" "function" is created
    Then the "lambda" "function" will be in "PENDING" state
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

  @guard @negative @create_function
  Scenario: a "lambda" "function" is created fails when the "lambda" "function" already existed
    Given the "lambda" "function" already existed
    When a "lambda" "function" is created
    Then the operation is rejected
