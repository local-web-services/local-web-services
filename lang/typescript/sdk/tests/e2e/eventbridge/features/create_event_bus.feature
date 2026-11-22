Feature: EventBridge - Create Event Bus

  Background:
    Given the eventbridge system is initialized

  Scenario: an "eventbridge" "event bus" is created
    Given the "eventbridge" "event bus" did not already exist
    When an "eventbridge" "event bus" is created
    Then the "eventbridge" "event bus" will exist

  Scenario: creating an "eventbridge" "event bus" that already exists is rejected
    Given the "eventbridge" "event bus" already existed
    When an "eventbridge" "event bus" is created
    Then the eventbridge operation is rejected
