@lambda @generated
Feature: Lambda - A Tag Is Added To A "Lambda" "Function"

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @tag_resource
  Scenario: a tag is added to a "lambda" "function"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "DELETING"
    And the "lambda" "function" was not "DELETED"
    When a tag is added to a "lambda" "function"
    Then the "lambda" "function" has the tag set
    And every active "lambda" "event source mapping" references an existing non-deleted "lambda" "function"
    And no "lambda" "function" in "DELETING" state has active executions
    And "lambda" "function" active execution count never exceeds reserved concurrency when set
    And "lambda" "function" async retry count never exceeds two
    And every "lambda" "event source mapping" has a valid status
    And every "lambda" "function" has a valid status
    And all "lambda" "async" "slot"s reference known "lambda" "function" IDs or are empty

  @guard @negative @tag_resource
  Scenario: a tag is added to a "lambda" "function" fails when the "lambda" "function" did not exist
    Given the "lambda" "function" did not exist
    When a tag is added to a "lambda" "function"
    Then the operation is rejected

  @guard @negative @tag_resource @lifecycle
  Scenario: a tag is added to a "lambda" "function" fails when the "lambda" "function" was "DELETING"
    Given the "lambda" "function" existed
    And the "lambda" "function" was "DELETING"
    When a tag is added to a "lambda" "function"
    Then the operation is rejected

  @guard @negative @tag_resource @lifecycle
  Scenario: a tag is added to a "lambda" "function" fails when the "lambda" "function" was "DELETED"
    Given the "lambda" "function" existed
    And the "lambda" "function" was not "DELETING"
    And the "lambda" "function" was "DELETED"
    When a tag is added to a "lambda" "function"
    Then the operation is rejected
