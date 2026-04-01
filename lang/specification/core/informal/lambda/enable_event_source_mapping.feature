@lambda @generated
Feature: lambda - A Disabled Lambda Event Source Mapping Was "Enabled"

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @minimal @happy @enable_event_source_mapping
  Scenario: a disabled lambda event source mapping was "ENABLED"
    Given the "lambda" "event source mapping" existed
    And the mapping was "DISABLED"
    When a disabled lambda event source mapping was "ENABLED"
    Then the mapping will be "ENABLED" and active
    And every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @guard @negative @enable_event_source_mapping
  Scenario: a disabled lambda event source mapping was "ENABLED" fails when the "lambda" "event source mapping" did not exist
    Given the "lambda" "event source mapping" did not exist
    When a disabled lambda event source mapping was "ENABLED"
    Then the operation is rejected

  @guard @negative @enable_event_source_mapping @lifecycle
  Scenario: a disabled lambda event source mapping was "ENABLED" fails when the mapping was not "DISABLED"
    Given the "lambda" "event source mapping" existed
    And the mapping was not "DISABLED"
    When a disabled lambda event source mapping was "ENABLED"
    Then the operation is rejected
