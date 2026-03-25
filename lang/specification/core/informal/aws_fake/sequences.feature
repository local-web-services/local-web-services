@awsfake @generated
Feature: AwsFake - Action Sequences

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then an "AWS" fake is deleted
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then an operation is added to an "AWS" fake
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then an operation is removed from an "AWS" fake
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then a request matching an "AWS" fake operation is intercepted
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then a request matching a header-filtered operation is intercepted
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then an "AWS" fake is created for a service
    Given fid in fake_status
    When an "AWS" fake is deleted
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then an operation is added to an "AWS" fake
    Given fid in fake_status
    When an "AWS" fake is deleted
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then an operation is removed from an "AWS" fake
    Given fid in fake_status
    When an "AWS" fake is deleted
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    When an "AWS" fake is deleted
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    When an "AWS" fake is deleted
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid in fake_status
    When an "AWS" fake is deleted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then an "AWS" fake is created for a service
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then an "AWS" fake is deleted
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then an operation is removed from an "AWS" fake
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then an "AWS" fake is created for a service
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then an "AWS" fake is deleted
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then an operation is added to an "AWS" fake
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then a request matching a header-filtered operation is intercepted
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an "AWS" fake is created for a service
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an "AWS" fake is deleted
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an operation is added to an "AWS" fake
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an operation is removed from an "AWS" fake
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then a request matching a header-filtered operation is intercepted
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an "AWS" fake is created for a service
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an "AWS" fake is deleted
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an operation is added to an "AWS" fake
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an operation is removed from an "AWS" fake
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then a request matching an "AWS" fake operation is intercepted
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is created for a service
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is deleted
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an operation is added to an "AWS" fake
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an operation is removed from an "AWS" fake
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then an "AWS" fake is deleted then an operation is added to an "AWS" fake
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When an "AWS" fake is deleted
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then an operation is added to an "AWS" fake then an operation is removed from an "AWS" fake
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When an operation is added to an "AWS" fake
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then an operation is removed from an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When an operation is removed from an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then a request matching an "AWS" fake operation is intercepted then a request matching a header-filtered operation is intercepted
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When a request matching an "AWS" fake operation is intercepted
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then a request matching a header-filtered operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When a request matching a header-filtered operation is intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is created for a service then a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is deleted
    Given fid not in fake_status
    When an "AWS" fake is created for a service
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then an "AWS" fake is created for a service then an operation is removed from an "AWS" fake
    Given fid in fake_status
    When an "AWS" fake is deleted
    When an "AWS" fake is created for a service
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then an operation is added to an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    When an "AWS" fake is deleted
    When an operation is added to an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then an operation is removed from an "AWS" fake then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    When an "AWS" fake is deleted
    When an operation is removed from an "AWS" fake
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then a request matching an "AWS" fake operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid in fake_status
    When an "AWS" fake is deleted
    When a request matching an "AWS" fake operation is intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then a request matching a header-filtered operation is intercepted then an "AWS" fake is created for a service
    Given fid in fake_status
    When an "AWS" fake is deleted
    When a request matching a header-filtered operation is intercepted
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an "AWS" fake is deleted then a request for an operation not covered by the "AWS" fake reaches the provider then an operation is added to an "AWS" fake
    Given fid in fake_status
    When an "AWS" fake is deleted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then an "AWS" fake is created for a service then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When an "AWS" fake is created for a service
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then an "AWS" fake is deleted then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When an "AWS" fake is deleted
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then an operation is removed from an "AWS" fake then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When an operation is removed from an "AWS" fake
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then a request matching an "AWS" fake operation is intercepted then an "AWS" fake is created for a service
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then a request matching a header-filtered operation is intercepted then an "AWS" fake is deleted
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When a request matching a header-filtered operation is intercepted
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is added to an "AWS" fake then a request for an operation not covered by the "AWS" fake reaches the provider then an operation is removed from an "AWS" fake
    Given fid in fake_status
    When an operation is added to an "AWS" fake
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then an "AWS" fake is created for a service then a request matching a header-filtered operation is intercepted
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When an "AWS" fake is created for a service
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then an "AWS" fake is deleted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When an "AWS" fake is deleted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then an operation is added to an "AWS" fake then an "AWS" fake is created for a service
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When an operation is added to an "AWS" fake
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then a request matching an "AWS" fake operation is intercepted then an "AWS" fake is deleted
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then a request matching a header-filtered operation is intercepted then an operation is added to an "AWS" fake
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When a request matching a header-filtered operation is intercepted
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: an operation is removed from an "AWS" fake then a request for an operation not covered by the "AWS" fake reaches the provider then a request matching an "AWS" fake operation is intercepted
    Given oid in op_status
    When an operation is removed from an "AWS" fake
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an "AWS" fake is created for a service then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When an "AWS" fake is created for a service
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an "AWS" fake is deleted then an "AWS" fake is created for a service
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When an "AWS" fake is deleted
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an operation is added to an "AWS" fake then an "AWS" fake is deleted
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When an operation is added to an "AWS" fake
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an operation is removed from an "AWS" fake then an operation is added to an "AWS" fake
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When an operation is removed from an "AWS" fake
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then a request matching a header-filtered operation is intercepted then an operation is removed from an "AWS" fake
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When a request matching a header-filtered operation is intercepted
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider then a request matching a header-filtered operation is intercepted
    Given oid in op_status
    When a request matching an "AWS" fake operation is intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an "AWS" fake is created for a service then an "AWS" fake is deleted
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When an "AWS" fake is created for a service
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an "AWS" fake is deleted then an operation is added to an "AWS" fake
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When an "AWS" fake is deleted
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an operation is added to an "AWS" fake then an operation is removed from an "AWS" fake
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When an operation is added to an "AWS" fake
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an operation is removed from an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When an operation is removed from an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then a request matching an "AWS" fake operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When a request matching an "AWS" fake operation is intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request matching a header-filtered operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is created for a service
    Given oid in op_status
    When a request matching a header-filtered operation is intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is created for a service then an operation is added to an "AWS" fake
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an "AWS" fake is created for a service
    When an operation is added to an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is deleted then an operation is removed from an "AWS" fake
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an "AWS" fake is deleted
    When an operation is removed from an "AWS" fake
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an operation is added to an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an operation is added to an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an operation is removed from an "AWS" fake then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When an operation is removed from an "AWS" fake
    When a request matching a header-filtered operation is intercepted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then a request matching an "AWS" fake operation is intercepted then an "AWS" fake is created for a service
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When a request matching an "AWS" fake operation is intercepted
    When an "AWS" fake is created for a service
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @exhaustive @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then a request matching a header-filtered operation is intercepted then an "AWS" fake is deleted
    Given fid in fake_status
    When a request for an operation not covered by the "AWS" fake reaches the provider
    When a request matching a header-filtered operation is intercepted
    When an "AWS" fake is deleted
    And every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service
