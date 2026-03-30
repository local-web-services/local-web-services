@eventsdynamodb @generated
Feature: EventsDynamodb - An Eventbridge Rule Is Created Targeting A Dynamodb Table

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @minimal @happy @create_rule
  Scenario: an EventBridge rule is created targeting a DynamoDB table
    Given the bus exists and is "ACTIVE"
    And the rule does not already exist
    And the table exists and is "ACTIVE"
    When an EventBridge rule is created targeting a DynamoDB table
    Then the rule is "DISABLED" on the bus with the DynamoDB target configured
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @guard @negative @create_rule
  Scenario: an EventBridge rule is created targeting a DynamoDB table fails when the bus does not exist or is not "ACTIVE"
    Given the bus does not exist or is not "ACTIVE"
    When an EventBridge rule is created targeting a DynamoDB table
    Then the operation is rejected

  @guard @negative @create_rule
  Scenario: an EventBridge rule is created targeting a DynamoDB table fails when the rule already exists
    Given the bus exists and is "ACTIVE"
    And the rule already exists
    When an EventBridge rule is created targeting a DynamoDB table
    Then the operation is rejected

  @guard @negative @create_rule
  Scenario: an EventBridge rule is created targeting a DynamoDB table fails when the table does not exist or is not "ACTIVE"
    Given the bus exists and is "ACTIVE"
    And the rule does not already exist
    And the table does not exist or is not "ACTIVE"
    When an EventBridge rule is created targeting a DynamoDB table
    Then the operation is rejected
