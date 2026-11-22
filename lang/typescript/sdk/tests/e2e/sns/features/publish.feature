Feature: SNS - Publish

  Background:
    Given the sns system is initialized
    And the "sns" "topic" exists

  Scenario: a message is published to a "sns" "topic"
    When a message is published to the "sns" "topic"
    Then the message will have a "sns" "MessageId"
