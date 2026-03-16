@secretsmanager @generated
Feature: Secretsmanager - All version identifiers are unique across secrets

  # Generated from FizzBee spec: secretsmanager.fizz

  Background:
    Given the system is initialized

  @invariant @version_ids_are_unique
  Scenario: all version identifiers are unique across secrets
    Then all version identifiers are unique across secrets
