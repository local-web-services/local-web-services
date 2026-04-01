@sts @generated
Feature: STS - The Sts Caller Identity Is Retrieved With A Session Token

  # Generated from FizzBee spec: sts.fizz
  # Safety invariants: SessionTokenContainsAccountId, CallerIdentityMatchesSession

  Background:
    Given the system is initialized

  @minimal @happy @get_caller_identity
  Scenario: the sts caller identity is retrieved with a session token
    Given the sts session existed
    When the sts caller identity is retrieved with a session token
    Then the "sts" "caller identity" will return the account from the session
    And every session token maps to a valid account id
    And caller identity account matches the session account when a session is used

  @guard @negative @get_caller_identity
  Scenario: the sts caller identity is retrieved with a session token fails when the sts session did not exist
    Given the sts session did not exist
    When the sts caller identity is retrieved with a session token
    Then the operation is rejected
