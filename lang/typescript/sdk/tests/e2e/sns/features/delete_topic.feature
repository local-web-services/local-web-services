Feature: SNS - Delete Topic

  Background:
    Given the sns system is initialized

  Scenario: an existing "sns" "topic" is deleted
    Given the "sns" "topic" exists
    When a "sns" "topic" is deleted
    Then the "sns" "topic" will not exist
