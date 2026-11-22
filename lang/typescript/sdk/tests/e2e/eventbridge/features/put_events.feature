Feature: EventBridge - Put Events

  Background:
    Given the eventbridge system is initialized

  Scenario: "eventbridge" "event"s are published to the "eventbridge" "event bus"
    Given the "eventbridge" "event bus" existed
    When "eventbridge" "event"s are published to the "eventbridge" "event bus"
    Then the "eventbridge" "event"s will be accepted
