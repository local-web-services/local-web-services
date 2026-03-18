@secretsmanager @generated
Feature: Secretsmanager - All secret names are unique

  # Generated from FizzBee spec: secretsmanager.fizz

  Background:
    Given the system is initialized

  @invariant @secret_names_are_unique
  Scenario: all secret names are unique
    Then all secret names are unique
