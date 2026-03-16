@eventsdynamodb @generated
Feature: EventsDynamodb - Action Sequences

  # Generated from FizzBee spec: events_dynamodb.fizz
  # Safety invariants: ItemReferencesExistingTable, MatchedEventReferencesExistingRule

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a DynamoDB table is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a table deletion is initiated
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is enabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is disabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge event bus is created
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is enabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is disabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge event bus is created
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is enabled
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is disabled
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is disabled
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is enabled
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a DynamoDB table is created then a table deletion is initiated
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a DynamoDB table is created then an EventBridge rule is enabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a DynamoDB table is created then an EventBridge rule is disabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a table deletion is initiated then a DynamoDB table is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a table deletion is initiated then an EventBridge rule is enabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a table deletion is initiated
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a table deletion is initiated then an EventBridge rule is disabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a table deletion is initiated
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is enabled then a DynamoDB table is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is enabled then a table deletion is initiated
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is enabled then an EventBridge rule is disabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is disabled then a DynamoDB table is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is disabled then a table deletion is initiated
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is disabled then an EventBridge rule is enabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid not in bus_status
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge event bus is created then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge event bus is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge event bus is created then an EventBridge rule is enabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge event bus is created then an EventBridge rule is disabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated then an EventBridge event bus is created
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated then an EventBridge rule is enabled
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated then an EventBridge rule is disabled
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is enabled then an EventBridge event bus is created
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is enabled then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is enabled then an EventBridge rule is disabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is disabled then an EventBridge event bus is created
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is disabled then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is disabled then an EventBridge rule is enabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid not in table_status
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge event bus is created then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge event bus is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge event bus is created then an EventBridge rule is enabled
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge event bus is created then an EventBridge rule is disabled
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created then an EventBridge event bus is created
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created then an EventBridge rule is enabled
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created then an EventBridge rule is disabled
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is enabled then an EventBridge event bus is created
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is enabled then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is enabled then an EventBridge rule is disabled
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is disabled then an EventBridge event bus is created
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is disabled then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is disabled then an EventBridge rule is enabled
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given tid in table_status
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created then a DynamoDB table is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created then a table deletion is initiated
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created then an EventBridge rule is enabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created then an EventBridge rule is disabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created then an EventBridge event bus is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created then a table deletion is initiated
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created then an EventBridge rule is enabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created then an EventBridge rule is disabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated then an EventBridge event bus is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated then a DynamoDB table is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated then an EventBridge rule is enabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated then an EventBridge rule is disabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled then an EventBridge event bus is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled then a DynamoDB table is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled then a table deletion is initiated
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled then an EventBridge rule is disabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled then an EventBridge event bus is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled then a DynamoDB table is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled then a table deletion is initiated
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled then an EventBridge rule is enabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given busid in bus_status
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge event bus is created then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge event bus is created then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge event bus is created then an EventBridge rule is disabled
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a DynamoDB table is created then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a DynamoDB table is created then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a DynamoDB table is created then an EventBridge rule is disabled
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a table deletion is initiated then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a table deletion is initiated
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a table deletion is initiated then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a table deletion is initiated then an EventBridge rule is disabled
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a table deletion is initiated
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is enabled
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is disabled then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is disabled then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is disabled then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge event bus is created then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge event bus is created then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge event bus is created then an EventBridge rule is enabled
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a DynamoDB table is created then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a DynamoDB table is created then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a DynamoDB table is created then an EventBridge rule is enabled
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a table deletion is initiated then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a table deletion is initiated
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a table deletion is initiated then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a table deletion is initiated then an EventBridge rule is enabled
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a table deletion is initiated
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is disabled
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is enabled then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is enabled then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is enabled then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge event bus is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge event bus is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a DynamoDB table is created then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a DynamoDB table is created
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then a table deletion is initiated then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When a table deletion is initiated
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is created targeting a DynamoDB table then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is created targeting a DynamoDB table
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is enabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is enabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an EventBridge rule is disabled then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an EventBridge rule is disabled
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge event bus is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge event bus is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a DynamoDB table is created
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a DynamoDB table is created
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then a table deletion is initiated
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When a table deletion is initiated
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is created targeting a DynamoDB table
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is created targeting a DynamoDB table
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is enabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is enabled
    And every existing item references a table that exists
    And every matched event references a rule that exists

  @exhaustive @sequence
  Scenario: an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted then an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target then an EventBridge rule is disabled
    Given rid in rule_status
    When an event matches an "ENABLED" rule but the DynamoDB write fails because the table is being deleted
    When an event matches an "ENABLED" rule and EventBridge writes an item to the DynamoDB target
    When an EventBridge rule is disabled
    And every existing item references a table that exists
    And every matched event references a rule that exists
