@awsfake @generated
Feature: AwsFake - An Operation Is Added To An Aws Fake

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @add_operation
  Scenario: an operation is added to an "AWS" fake
    Given the "AWS" fake exists
    And the "AWS" fake is "ACTIVE"
    And an operation slot is available
    When an operation is added to an "AWS" fake
    Then the operation is "ACTIVE" on the "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @standard @negative @add_operation
  Scenario: an operation is added to an "AWS" fake fails when the "AWS" fake does not exist
    Given the "AWS" fake does not exist
    When an operation is added to an "AWS" fake
    Then the operation is rejected

  @standard @negative @internal @add_operation
  Scenario: an operation is added to an "AWS" fake fails when the "AWS" fake is not "ACTIVE"
    Given the "AWS" fake exists
    And the "AWS" fake is not "ACTIVE"
    When an operation is added to an "AWS" fake
    Then the operation is rejected

  @standard @negative @internal @add_operation
  Scenario: an operation is added to an "AWS" fake fails when no operation slot is available
    Given the "AWS" fake exists
    And the "AWS" fake is "ACTIVE"
    And no operation slot is available
    When an operation is added to an "AWS" fake
    Then the operation is rejected
