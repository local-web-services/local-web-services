Feature: Secrets Manager - Create Secret

  Background:
    Given the secrets system is initialized

  Scenario: a "secrets" "secret" is created
    When a "secrets" "secret" is created
    Then the "secrets" "secret" will exist

  Scenario: creating a duplicate "secrets" "secret" is rejected
    Given the "secrets" "secret" already exists
    When a "secrets" "secret" is created
    Then the secrets operation is rejected
