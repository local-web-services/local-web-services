@lambda @generated
Feature: Lambda - A "Lambda" "Function"'S Configuration Is Updated

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @update_function_configuration
  Scenario: a "lambda" "function"'s configuration is updated
    Given the "lambda" "function" existed
    And the "lambda" "function" was "ACTIVE"
    When a "lambda" "function"'s configuration is updated
    Then the "lambda" "function" configuration will be updated while remaining "ACTIVE"
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

  @guard @negative @update_function_configuration
  Scenario: a "lambda" "function"'s configuration is updated fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a "lambda" "function"'s configuration is updated
    Then the operation is rejected

  @guard @negative @update_function_configuration @lifecycle
  Scenario: a "lambda" "function"'s configuration is updated fails when the "lambda" "function" was not "ACTIVE"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "ACTIVE"
    When a "lambda" "function"'s configuration is updated
    Then the operation is rejected
