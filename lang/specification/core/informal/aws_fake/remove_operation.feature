@awsfake @generated
Feature: AwsFake - An Operation Is Removed From An Aws Fake

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @remove_operation
  Scenario: an operation is removed from an "AWS" fake
    Given the operation exists
    And the operation is "ACTIVE"
    When an operation is removed from an "AWS" fake
    Then the operation is "DELETED"
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @standard @negative @remove_operation
  Scenario: an operation is removed from an "AWS" fake fails when the operation does not exist
    Given the operation does not exist
    When an operation is removed from an "AWS" fake
    Then the operation is rejected

  @standard @negative @remove_operation
  Scenario: an operation is removed from an "AWS" fake fails when the operation is not "ACTIVE"
    Given the operation exists
    And the operation is not "ACTIVE"
    When an operation is removed from an "AWS" fake
    Then the operation is rejected
