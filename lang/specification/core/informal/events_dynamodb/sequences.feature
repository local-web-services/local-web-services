@eventsdynamodb @generated
Feature: EventsDynamodb - Action Sequences

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @sequence
  Scenario: an EventBridge event bus is created then a "dynamodb" "table" is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "dynamodb" "table" deletion is initiated
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then an "eventbridge" "rule" was "ENABLED"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then an "eventbridge" "rule" was "DISABLED"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an EventBridge event bus is created
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" deletion is initiated
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an "eventbridge" "rule" was "ENABLED"
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an "eventbridge" "rule" was "DISABLED"
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an EventBridge event bus is created
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then a "dynamodb" "table" is created
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an "eventbridge" "rule" was "ENABLED"
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an "eventbridge" "rule" was "DISABLED"
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an EventBridge event bus is created
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then a "dynamodb" "table" is created
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then a "dynamodb" "table" deletion is initiated
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an "eventbridge" "rule" was "ENABLED"
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an "eventbridge" "rule" was "DISABLED"
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an EventBridge event bus is created
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then a "dynamodb" "table" is created
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then a "dynamodb" "table" deletion is initiated
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" was "DISABLED"
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an EventBridge event bus is created
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then a "dynamodb" "table" is created
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then a "dynamodb" "table" deletion is initiated
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" was "ENABLED"
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a "dynamodb" "table" is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a "dynamodb" "table" deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an "eventbridge" "rule" was "ENABLED"
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an "eventbridge" "rule" was "DISABLED"
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "eventbridge" "rule" was "ENABLED"
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "eventbridge" "rule" was "DISABLED"
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "dynamodb" "table" is created then a "dynamodb" "table" deletion is initiated
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then a "dynamodb" "table" deletion is initiated then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a "dynamodb" "table" deletion is initiated
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an "eventbridge" "rule" was "ENABLED"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" was "DISABLED"
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then an "eventbridge" "rule" was "DISABLED" then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an "eventbridge" "rule" was "DISABLED"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an EventBridge event bus is created then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an EventBridge event bus is created
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then a "dynamodb" "table" deletion is initiated then an "eventbridge" "rule" was "ENABLED"
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" deletion is initiated
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an "eventbridge" "rule" was "DISABLED"
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an "eventbridge" "rule" was "ENABLED" then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an "eventbridge" "rule" was "ENABLED"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an "eventbridge" "rule" was "DISABLED" then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an "eventbridge" "rule" was "DISABLED"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" deletion is initiated
    Given tid not in table_status
    When a "dynamodb" "table" is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an EventBridge event bus is created then an "eventbridge" "rule" was "ENABLED"
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an EventBridge event bus is created
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then a "dynamodb" "table" is created then an "eventbridge" "rule" was "DISABLED"
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When a "dynamodb" "table" is created
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an "eventbridge" "rule" was "ENABLED" then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an "eventbridge" "rule" was "ENABLED"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an "eventbridge" "rule" was "DISABLED" then an EventBridge event bus is created
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an "eventbridge" "rule" was "DISABLED"
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a "dynamodb" "table" is created
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: a "dynamodb" "table" deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given tid in table_status
    When a "dynamodb" "table" deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an EventBridge event bus is created then an "eventbridge" "rule" was "DISABLED"
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an EventBridge event bus is created
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then a "dynamodb" "table" is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When a "dynamodb" "table" is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then a "dynamodb" "table" deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When a "dynamodb" "table" deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an "eventbridge" "rule" was "ENABLED" then an EventBridge event bus is created
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an "eventbridge" "rule" was "ENABLED"
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an "eventbridge" "rule" was "DISABLED" then a "dynamodb" "table" is created
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an "eventbridge" "rule" was "DISABLED"
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a "dynamodb" "table" deletion is initiated
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "eventbridge" "rule" was "ENABLED"
    Given busid in bus_status
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then a "dynamodb" "table" is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When a "dynamodb" "table" is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then a "dynamodb" "table" deletion is initiated then an EventBridge event bus is created
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When a "dynamodb" "table" deletion is initiated
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is created targeting a "dynamodb" "table" then a "dynamodb" "table" is created
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" was "DISABLED" then a "dynamodb" "table" deletion is initiated
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" was "DISABLED"
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "ENABLED" then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "eventbridge" "rule" was "DISABLED"
    Given rid in rule_status
    When an "eventbridge" "rule" was "ENABLED"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then a "dynamodb" "table" is created then an EventBridge event bus is created
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When a "dynamodb" "table" is created
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then a "dynamodb" "table" deletion is initiated then a "dynamodb" "table" is created
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When a "dynamodb" "table" deletion is initiated
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" is created targeting a "dynamodb" "table" then a "dynamodb" "table" deletion is initiated
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an "eventbridge" "rule" was "ENABLED"
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an "eventbridge" "rule" was "DISABLED" then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an "eventbridge" "rule" was "DISABLED"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created then a "dynamodb" "table" is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a "dynamodb" "table" is created then a "dynamodb" "table" deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a "dynamodb" "table" is created
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a "dynamodb" "table" deletion is initiated then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a "dynamodb" "table" deletion is initiated
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an "eventbridge" "rule" was "ENABLED"
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an "eventbridge" "rule" was "ENABLED" then an "eventbridge" "rule" was "DISABLED"
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an "eventbridge" "rule" was "ENABLED"
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an "eventbridge" "rule" was "DISABLED" then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an "eventbridge" "rule" was "DISABLED"
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an EventBridge event bus is created then a "dynamodb" "table" deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an EventBridge event bus is created
    When a "dynamodb" "table" deletion is initiated
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" is created then an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" is created
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then a "dynamodb" "table" deletion is initiated then an "eventbridge" "rule" was "ENABLED"
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When a "dynamodb" "table" deletion is initiated
    When an "eventbridge" "rule" was "ENABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "eventbridge" "rule" is created targeting a "dynamodb" "table" then an "eventbridge" "rule" was "DISABLED"
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "eventbridge" "rule" is created targeting a "dynamodb" "table"
    When an "eventbridge" "rule" was "DISABLED"
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "eventbridge" "rule" was "ENABLED" then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "eventbridge" "rule" was "ENABLED"
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an "eventbridge" "rule" was "DISABLED" then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an "eventbridge" "rule" was "DISABLED"
    When an EventBridge event bus is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists

  @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a "dynamodb" "table" is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the "dynamodb" "table" is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a "dynamodb" "table" is created
    And every existing item references a "dynamodb" "table" that exists
    And every matched event references a rule that exists
