Feature: SNS - Create Topic

  Background:
    Given the sns system is initialized

  Scenario: a "sns" "topic" is created
    When a "sns" "topic" is created
    Then the "sns" "topic" will exist
