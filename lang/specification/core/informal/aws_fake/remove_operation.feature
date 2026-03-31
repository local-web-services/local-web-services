@awsfake @generated
Feature: AwsFake - An Operation Is Removed From An Aws Fake

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @remove_operation
  Scenario: an operation is removed from an "AWS" fake
    Given the operation existed
    And the operation was "ACTIVE"
    When an operation is removed from an "AWS" fake
    Then the operation will be deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @guard @negative @remove_operation
  Scenario: an operation is removed from an "AWS" fake fails when the operation did not exist
    Given the operation did not exist
    When an operation is removed from an "AWS" fake
    Then the operation is rejected

  @guard @negative @remove_operation
  Scenario: an operation is removed from an "AWS" fake fails when the operation was not "ACTIVE"
    Given the operation existed
    And the operation was not "ACTIVE"
    When an operation is removed from an "AWS" fake
    Then the operation is rejected
