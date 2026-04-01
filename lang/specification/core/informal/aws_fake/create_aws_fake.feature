@awsfake @generated
Feature: AwsFake - An "Aws Fake" Is Created For A Service

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @create_aws_fake
  Scenario: an "aws fake" is created for a service
    Given the "aws fake" did not already exist
    When an "aws fake" is created for a service
    Then the "AWS" fake will be "ACTIVE"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @guard @negative @create_aws_fake
  Scenario: an "aws fake" is created for a service fails when the "aws fake" already existed
    Given the "aws fake" already existed
    When an "aws fake" is created for a service
    Then the operation is rejected
