@awsfake @generated
Feature: AwsFake - An Aws Fake Is Deleted

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @delete_aws_fake
  Scenario: an "AWS" fake is deleted
    Given the "AWS" fake exists
    And the "AWS" fake is "ACTIVE"
    When an "AWS" fake is deleted
    Then the "AWS" fake is "DELETED" and its operations are removed
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @standard @negative @delete_aws_fake
  Scenario: an "AWS" fake is deleted fails when the "AWS" fake does not exist
    Given the "AWS" fake does not exist
    When an "AWS" fake is deleted
    Then the operation is rejected

  @standard @negative @delete_aws_fake
  Scenario: an "AWS" fake is deleted fails when the "AWS" fake is not "ACTIVE"
    Given the "AWS" fake exists
    And the "AWS" fake is not "ACTIVE"
    When an "AWS" fake is deleted
    Then the operation is rejected
