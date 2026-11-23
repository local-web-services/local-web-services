Feature: Secrets Manager - Delete Secret

  Background:
    Given the secrets system is initialized

  Scenario: an existing "secrets" "secret" is deleted
    Given the "secrets" "secret" already exists
    When a "secrets" "secret" is deleted
    Then the "secrets" "secret" will not exist
