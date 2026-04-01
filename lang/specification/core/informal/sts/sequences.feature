@sts @generated
Feature: Sts - Action Sequences

  # Generated from FizzBee spec: sts.fizz
  # Safety invariants: SessionTokenContainsAccountId, CallerIdentityMatchesSession

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "sts" "role" is assumed for an account then the "sts" "caller identity" is retrieved with a session token
    Given sid not in session_account
    When an "sts" "role" is assumed for an account
    When the "sts" "caller identity" is retrieved with a session token
    And every "sts" "session" token maps to a valid account id
    And the "sts" "caller identity" account matches the "sts" "session" account

  @sequence
  Scenario: the "sts" "caller identity" is retrieved with a session token then an "sts" "role" is assumed for an account
    Given sid in session_account
    When the "sts" "caller identity" is retrieved with a session token
    When an "sts" "role" is assumed for an account
    And every "sts" "session" token maps to a valid account id
    And the "sts" "caller identity" account matches the "sts" "session" account
