@awsfake @generated
Feature: AwsFake - Action Sequences

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "AWS" fake is created for a service then an "AWS" fake is deleted
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is created for a service then an operation is added to an "AWS" fake
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is created for a service then an operation is removed from an "AWS" fake
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is created for a service then a request matching an "AWS" fake operation is intercepted
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is created for a service then a request matching a header-filtered operation is intercepted
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is created for a service then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then an "AWS" fake is created for a service
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then an operation is added to an "AWS" fake
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then an operation is removed from an "AWS" fake
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then an "AWS" fake is created for a service
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then an "AWS" fake is deleted
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then an operation is removed from an "AWS" fake
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then an "AWS" fake is created for a service
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then an "AWS" fake is deleted
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then an operation is added to an "AWS" fake
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then a request matching a header-filtered operation is intercepted
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an "AWS" fake is created for a service
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an "AWS" fake is deleted
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an operation is added to an "AWS" fake
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an operation is removed from an "AWS" fake
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then a request matching a header-filtered operation is intercepted
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an "AWS" fake is created for a service
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an "AWS" fake is deleted
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an operation is added to an "AWS" fake
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an operation is removed from an "AWS" fake
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then a request matching an "AWS" fake operation is intercepted
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is created for a service
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is deleted
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an operation is added to an "AWS" fake
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an operation is removed from an "AWS" fake
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is created for a service then an "AWS" fake is deleted then an operation is added to an "AWS" fake
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    Given an "AWS" fake has been deleted
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is created for a service then an operation is added to an "AWS" fake then an operation is removed from an "AWS" fake
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    Given an operation has been added to an "AWS" fake
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is created for a service then an operation is removed from an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    Given an operation has been removed from an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is created for a service then a request matching an "AWS" fake operation is intercepted then a request matching a header-filtered operation is intercepted
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    Given a request matching an "AWS" fake operation has been intercepted
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is created for a service then a request matching a header-filtered operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    Given a request matching a header-filtered operation has been intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is created for a service then a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is deleted
    Given fid not in fake_status
    Given an "AWS" fake has been created for a service
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then an "AWS" fake is created for a service then an operation is removed from an "AWS" fake
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    Given an "AWS" fake has been created for a service
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then an operation is added to an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    Given an operation has been added to an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then an operation is removed from an "AWS" fake then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    Given an operation has been removed from an "AWS" fake
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then a request matching an "AWS" fake operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    Given a request matching an "AWS" fake operation has been intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then a request matching a header-filtered operation is intercepted then an "AWS" fake is created for a service
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    Given a request matching a header-filtered operation has been intercepted
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an "AWS" fake is deleted then a request for an operation not covered by the "AWS" fake reaches the provider then an operation is added to an "AWS" fake
    Given fid in fake_status
    Given an "AWS" fake has been deleted
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then an "AWS" fake is created for a service then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    Given an "AWS" fake has been created for a service
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then an "AWS" fake is deleted then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    Given an "AWS" fake has been deleted
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then an operation is removed from an "AWS" fake then a request for an operation not covered by the "AWS" fake reaches the provider
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    Given an operation has been removed from an "AWS" fake
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then a request matching an "AWS" fake operation is intercepted then an "AWS" fake is created for a service
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    Given a request matching an "AWS" fake operation has been intercepted
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then a request matching a header-filtered operation is intercepted then an "AWS" fake is deleted
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    Given a request matching a header-filtered operation has been intercepted
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is added to an "AWS" fake then a request for an operation not covered by the "AWS" fake reaches the provider then an operation is removed from an "AWS" fake
    Given fid in fake_status
    Given an operation has been added to an "AWS" fake
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then an "AWS" fake is created for a service then a request matching a header-filtered operation is intercepted
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    Given an "AWS" fake has been created for a service
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then an "AWS" fake is deleted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    Given an "AWS" fake has been deleted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then an operation is added to an "AWS" fake then an "AWS" fake is created for a service
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    Given an operation has been added to an "AWS" fake
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then a request matching an "AWS" fake operation is intercepted then an "AWS" fake is deleted
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    Given a request matching an "AWS" fake operation has been intercepted
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then a request matching a header-filtered operation is intercepted then an operation is added to an "AWS" fake
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    Given a request matching a header-filtered operation has been intercepted
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: an operation is removed from an "AWS" fake then a request for an operation not covered by the "AWS" fake reaches the provider then a request matching an "AWS" fake operation is intercepted
    Given oid in op_status
    Given an operation has been removed from an "AWS" fake
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an "AWS" fake is created for a service then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    Given an "AWS" fake has been created for a service
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an "AWS" fake is deleted then an "AWS" fake is created for a service
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    Given an "AWS" fake has been deleted
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an operation is added to an "AWS" fake then an "AWS" fake is deleted
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    Given an operation has been added to an "AWS" fake
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then an operation is removed from an "AWS" fake then an operation is added to an "AWS" fake
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    Given an operation has been removed from an "AWS" fake
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then a request matching a header-filtered operation is intercepted then an operation is removed from an "AWS" fake
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    Given a request matching a header-filtered operation has been intercepted
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching an "AWS" fake operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider then a request matching a header-filtered operation is intercepted
    Given oid in op_status
    Given a request matching an "AWS" fake operation has been intercepted
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an "AWS" fake is created for a service then an "AWS" fake is deleted
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    Given an "AWS" fake has been created for a service
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an "AWS" fake is deleted then an operation is added to an "AWS" fake
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    Given an "AWS" fake has been deleted
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an operation is added to an "AWS" fake then an operation is removed from an "AWS" fake
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    Given an operation has been added to an "AWS" fake
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then an operation is removed from an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    Given an operation has been removed from an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then a request matching an "AWS" fake operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    Given a request matching an "AWS" fake operation has been intercepted
    When a request for an operation not covered by the "AWS" fake reaches the provider
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered operation is intercepted then a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is created for a service
    Given oid in op_status
    Given a request matching a header-filtered operation has been intercepted
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is created for a service then an operation is added to an "AWS" fake
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    Given an "AWS" fake has been created for a service
    When an operation is added to an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an "AWS" fake is deleted then an operation is removed from an "AWS" fake
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    Given an "AWS" fake has been deleted
    When an operation is removed from an "AWS" fake
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an operation is added to an "AWS" fake then a request matching an "AWS" fake operation is intercepted
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    Given an operation has been added to an "AWS" fake
    When a request matching an "AWS" fake operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then an operation is removed from an "AWS" fake then a request matching a header-filtered operation is intercepted
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    Given an operation has been removed from an "AWS" fake
    When a request matching a header-filtered operation is intercepted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then a request matching an "AWS" fake operation is intercepted then an "AWS" fake is created for a service
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    Given a request matching an "AWS" fake operation has been intercepted
    When an "AWS" fake is created for a service
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service

  @sequence
  Scenario: a request for an operation not covered by the "AWS" fake reaches the provider then a request matching a header-filtered operation is intercepted then an "AWS" fake is deleted
    Given fid in fake_status
    Given a request for an operation not covered by the "AWS" fake has reached the provider
    Given a request matching a header-filtered operation has been intercepted
    When an "AWS" fake is deleted
    Then every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake
    And every "AWS" fake is tied to a known service
