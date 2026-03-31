@awsfake @generated
Feature: AwsFake - An Aws Fake Is Created For A Service

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @create_aws_fake
  Scenario: an "AWS" fake is created for a service
    Given the "AWS" fake did not already exist
    When an "AWS" fake is created for a service
    Then the "AWS" fake will be "ACTIVE"
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @guard @negative @create_aws_fake
  Scenario: an "AWS" fake is created for a service fails when the "AWS" fake already existed
    Given the "AWS" fake already existed
    When an "AWS" fake is created for a service
    Then the operation is rejected
