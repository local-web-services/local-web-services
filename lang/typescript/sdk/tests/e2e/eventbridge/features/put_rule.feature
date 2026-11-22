Feature: EventBridge - Put Rule

  Background:
    Given the eventbridge system is initialized

  Scenario: an "eventbridge" "rule" is created on the "eventbridge" "event bus"
    Given the "eventbridge" "event bus" existed
    When an "eventbridge" "rule" is created on the "eventbridge" "event bus"
    Then the "eventbridge" "rule" will exist on the "eventbridge" "event bus"
