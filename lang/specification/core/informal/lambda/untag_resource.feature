@lambda @generated
Feature: Lambda - A Tag Is Removed From A "Lambda" "Function"

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @untag_resource
  Scenario: a tag is removed from a "lambda" "function"
    Given the "lambda" "function" existed
    And the tag existed on the "lambda" "function"
    And the "lambda" "function" tag was set
    When a tag is removed from a "lambda" "function"
    Then the tag will be cleared from the "lambda" "function"
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

  @guard @negative @untag_resource
  Scenario: a tag is removed from a "lambda" "function" fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a tag is removed from a "lambda" "function"
    Then the operation is rejected

  @guard @negative @untag_resource
  Scenario: a tag is removed from a "lambda" "function" fails when the tag did not exist on the "lambda" "function"
    Given the "lambda" "function" existed
    And the tag did not exist on the "lambda" "function"
    When a tag is removed from a "lambda" "function"
    Then the operation is rejected

  @guard @negative @untag_resource
  Scenario: a tag is removed from a "lambda" "function" fails when the "lambda" "function" tag was not set
    Given the "lambda" "function" existed
    And the tag existed on the "lambda" "function"
    And the "lambda" "function" tag was not set
    When a tag is removed from a "lambda" "function"
    Then the operation is rejected
