@awsfake @generated
Feature: AwsFake - A Request For An "Operation" Not Covered By The "Aws Fake" Reaches The Provider

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @fallthrough_request
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider
    Given the "aws fake" existed
    And the "AWS" fake was "ACTIVE"
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    Then the request passes through to the real "aws" provider unchanged
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @guard @negative @fallthrough_request
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider fails when the "aws fake" did not exist
    Given the "aws fake" did not exist
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    Then the operation is rejected

  @guard @negative @fallthrough_request
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider fails when the "AWS" fake was not "ACTIVE"
    Given the "aws fake" existed
    And the "AWS" fake was not "ACTIVE"
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    Then the operation is rejected
