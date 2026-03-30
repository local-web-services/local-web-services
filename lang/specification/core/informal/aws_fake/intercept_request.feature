@awsfake @generated
Feature: AwsFake - A Request Matching An Aws Fake Operation Is Intercepted

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @minimal @happy @intercept_request
  Scenario: a request matching an "AWS" fake operation is intercepted
    Given the operation exists
    And the operation is "ACTIVE"
    And the operation has no header filter
    When a request matching an "AWS" fake operation is intercepted
    Then the canned response is returned and the request does not reach the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @standard @negative @intercept_request
  Scenario: a request matching an "AWS" fake operation is intercepted fails when the operation does not exist
    Given the operation does not exist
    When a request matching an "AWS" fake operation is intercepted
    Then the operation is rejected

  @standard @negative @internal @intercept_request
  Scenario: a request matching an "AWS" fake operation is intercepted fails when the operation is not "ACTIVE"
    Given the operation exists
    And the operation is not "ACTIVE"
    When a request matching an "AWS" fake operation is intercepted
    Then the operation is rejected

  @standard @negative @internal @intercept_request
  Scenario: a request matching an "AWS" fake operation is intercepted fails when the operation has a header filter
    Given the operation exists
    And the operation is "ACTIVE"
    And the operation has a header filter
    When a request matching an "AWS" fake operation is intercepted
    Then the operation is rejected
