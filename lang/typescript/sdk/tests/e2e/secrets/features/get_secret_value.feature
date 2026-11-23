Feature: Secrets Manager - Get Secret Value

  Background:
    Given the secrets system is initialized

  Scenario: an existing "secrets" "secret" value is retrieved
    Given the "secrets" "secret" already exists
    When a "secrets" "secret" value is retrieved
    Then the "secrets" "secret" value will be returned

  Scenario: retrieving a missing "secrets" "secret" returns an error
    Given the "secrets" "secret" does not exist
    When a "secrets" "secret" value is retrieved
    Then the secrets operation is rejected
