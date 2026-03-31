@awsfake @generated
Feature: AwsFake - An Aws Fake Is Deleted

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @delete_aws_fake
  Scenario: an "AWS" fake is deleted
    Given the "AWS" fake existed
    And the "AWS" fake was "ACTIVE"
    When an "AWS" fake is deleted
    Then the "AWS" fake will be deleted and its operations will be removed
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @guard @negative @delete_aws_fake
  Scenario: an "AWS" fake is deleted fails when the "AWS" fake did not exist
    Given the "AWS" fake did not exist
    When an "AWS" fake is deleted
    Then the operation is rejected

  @guard @negative @delete_aws_fake
  Scenario: an "AWS" fake is deleted fails when the "AWS" fake was not "ACTIVE"
    Given the "AWS" fake existed
    And the "AWS" fake was not "ACTIVE"
    When an "AWS" fake is deleted
    Then the operation is rejected
