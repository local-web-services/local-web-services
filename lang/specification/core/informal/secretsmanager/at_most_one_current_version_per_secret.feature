@secretsmanager @generated
Feature: Secretsmanager - At most one current version exists per secret

  # Generated from FizzBee spec: secretsmanager.fizz

  Background:
    Given the system is initialized

  @invariant @at_most_one_current_version_per_secret
  Scenario: at most one current version exists per secret
    Then at most one current version exists per secret
