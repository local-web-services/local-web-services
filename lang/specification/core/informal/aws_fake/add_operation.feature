@awsfake @generated
Feature: AwsFake - An "Operation" Is Added To An "Aws Fake"

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @add_operation
  Scenario: an "operation" is added to an "aws fake"
    Given the "aws fake" existed
    And the "AWS" fake was "ACTIVE"
    And an "operation" "slot" was "available"
    When an "operation" is added to an "aws fake"
    Then the "aws fake" "operation" will be "ACTIVE" on the "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @guard @negative @add_operation
  Scenario: an "operation" is added to an "aws fake" fails when the "aws fake" did not exist
    Given the "aws fake" did not exist
    When an "operation" is added to an "aws fake"
    Then the operation is rejected

  @guard @negative @add_operation
  Scenario: an "operation" is added to an "aws fake" fails when the "AWS" fake was not "ACTIVE"
    Given the "aws fake" existed
    And the "AWS" fake was not "ACTIVE"
    When an "operation" is added to an "aws fake"
    Then the operation is rejected

  @guard @negative @add_operation @capacity
  Scenario: an "operation" is added to an "aws fake" fails when no "operation" "slot" was "available"
    Given the "aws fake" existed
    And the "AWS" fake was "ACTIVE"
    And no "operation" "slot" was "available"
    When an "operation" is added to an "aws fake"
    Then the operation is rejected
