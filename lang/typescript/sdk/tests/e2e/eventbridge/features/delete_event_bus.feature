Feature: EventBridge - Delete Event Bus

  Background:
    Given the eventbridge system is initialized

  Scenario: an "eventbridge" "event bus" is deleted
    Given the "eventbridge" "event bus" existed
    When an "eventbridge" "event bus" is deleted
    Then the "eventbridge" "event bus" will not exist

  Scenario: deleting an "eventbridge" "event bus" that does not exist is rejected
    Given the "eventbridge" "event bus" did not already exist
    When an "eventbridge" "event bus" is deleted
    Then the eventbridge operation is rejected
