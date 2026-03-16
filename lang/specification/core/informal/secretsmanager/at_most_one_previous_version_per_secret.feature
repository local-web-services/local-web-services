@secretsmanager @generated
Feature: Secretsmanager - At most one previous version exists per secret

  # Generated from FizzBee spec: secretsmanager.fizz

  Background:
    Given the system is initialized

  @invariant @at_most_one_previous_version_per_secret
  Scenario: at most one previous version exists per secret
    Then at most one previous version exists per secret
