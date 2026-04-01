@awsfake @generated
Feature: AwsFake - Action Sequences

  # Generated from FizzBee spec: aws_fake.fizz
  # Safety invariants: ActiveOperationsBelongToActiveFakes, FakesReferenceKnownServices

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "aws fake" is created for a service then an "aws fake" is deleted
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is created for a service then an "operation" is added to an "aws fake"
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is created for a service then an "operation" is removed from an "aws fake"
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is created for a service then a request matching an "aws fake" "operation" is intercepted
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is created for a service then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is created for a service then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then an "aws fake" is created for a service
    Given fid in fake_status
    When an "aws fake" is deleted
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then an "operation" is added to an "aws fake"
    Given fid in fake_status
    When an "aws fake" is deleted
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then an "operation" is removed from an "aws fake"
    Given fid in fake_status
    When an "aws fake" is deleted
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then a request matching an "aws fake" "operation" is intercepted
    Given fid in fake_status
    When an "aws fake" is deleted
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given fid in fake_status
    When an "aws fake" is deleted
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given fid in fake_status
    When an "aws fake" is deleted
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then an "aws fake" is created for a service
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then an "aws fake" is deleted
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then an "operation" is removed from an "aws fake"
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then a request matching an "aws fake" "operation" is intercepted
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then an "aws fake" is created for a service
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then an "aws fake" is deleted
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then an "operation" is added to an "aws fake"
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then a request matching an "aws fake" "operation" is intercepted
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then an "aws fake" is created for a service
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then an "aws fake" is deleted
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then an "operation" is added to an "aws fake"
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then an "operation" is removed from an "aws fake"
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then an "aws fake" is created for a service
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then an "aws fake" is deleted
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then an "operation" is added to an "aws fake"
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then an "operation" is removed from an "aws fake"
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then a request matching an "aws fake" "operation" is intercepted
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then an "aws fake" is created for a service
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then an "aws fake" is deleted
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then an "operation" is added to an "aws fake"
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then an "operation" is removed from an "aws fake"
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then a request matching an "aws fake" "operation" is intercepted
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is created for a service then an "aws fake" is deleted then an "operation" is added to an "aws fake"
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When an "aws fake" is deleted
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is created for a service then an "operation" is added to an "aws fake" then an "operation" is removed from an "aws fake"
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When an "operation" is added to an "aws fake"
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is created for a service then an "operation" is removed from an "aws fake" then a request matching an "aws fake" "operation" is intercepted
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When an "operation" is removed from an "aws fake"
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is created for a service then a request matching an "aws fake" "operation" is intercepted then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When a request matching an "aws fake" "operation" is intercepted
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is created for a service then a request matching a header-filtered "aws fake" "operation" is intercepted then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is created for a service then a request for an "operation" not covered by the "aws fake" reaches the provider then an "aws fake" is deleted
    Given fid not in fake_status
    When an "aws fake" is created for a service
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then an "aws fake" is created for a service then an "operation" is removed from an "aws fake"
    Given fid in fake_status
    When an "aws fake" is deleted
    When an "aws fake" is created for a service
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then an "operation" is added to an "aws fake" then a request matching an "aws fake" "operation" is intercepted
    Given fid in fake_status
    When an "aws fake" is deleted
    When an "operation" is added to an "aws fake"
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then an "operation" is removed from an "aws fake" then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given fid in fake_status
    When an "aws fake" is deleted
    When an "operation" is removed from an "aws fake"
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then a request matching an "aws fake" "operation" is intercepted then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given fid in fake_status
    When an "aws fake" is deleted
    When a request matching an "aws fake" "operation" is intercepted
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then a request matching a header-filtered "aws fake" "operation" is intercepted then an "aws fake" is created for a service
    Given fid in fake_status
    When an "aws fake" is deleted
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "aws fake" is deleted then a request for an "operation" not covered by the "aws fake" reaches the provider then an "operation" is added to an "aws fake"
    Given fid in fake_status
    When an "aws fake" is deleted
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then an "aws fake" is created for a service then a request matching an "aws fake" "operation" is intercepted
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When an "aws fake" is created for a service
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then an "aws fake" is deleted then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When an "aws fake" is deleted
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then an "operation" is removed from an "aws fake" then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When an "operation" is removed from an "aws fake"
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then a request matching an "aws fake" "operation" is intercepted then an "aws fake" is created for a service
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When a request matching an "aws fake" "operation" is intercepted
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then a request matching a header-filtered "aws fake" "operation" is intercepted then an "aws fake" is deleted
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is added to an "aws fake" then a request for an "operation" not covered by the "aws fake" reaches the provider then an "operation" is removed from an "aws fake"
    Given fid in fake_status
    When an "operation" is added to an "aws fake"
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then an "aws fake" is created for a service then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When an "aws fake" is created for a service
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then an "aws fake" is deleted then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When an "aws fake" is deleted
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then an "operation" is added to an "aws fake" then an "aws fake" is created for a service
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When an "operation" is added to an "aws fake"
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then a request matching an "aws fake" "operation" is intercepted then an "aws fake" is deleted
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When a request matching an "aws fake" "operation" is intercepted
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then a request matching a header-filtered "aws fake" "operation" is intercepted then an "operation" is added to an "aws fake"
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: an "operation" is removed from an "aws fake" then a request for an "operation" not covered by the "aws fake" reaches the provider then a request matching an "aws fake" "operation" is intercepted
    Given oid in op_status
    When an "operation" is removed from an "aws fake"
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then an "aws fake" is created for a service then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When an "aws fake" is created for a service
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then an "aws fake" is deleted then an "aws fake" is created for a service
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When an "aws fake" is deleted
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then an "operation" is added to an "aws fake" then an "aws fake" is deleted
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When an "operation" is added to an "aws fake"
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then an "operation" is removed from an "aws fake" then an "operation" is added to an "aws fake"
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When an "operation" is removed from an "aws fake"
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then a request matching a header-filtered "aws fake" "operation" is intercepted then an "operation" is removed from an "aws fake"
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching an "aws fake" "operation" is intercepted then a request for an "operation" not covered by the "aws fake" reaches the provider then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given oid in op_status
    When a request matching an "aws fake" "operation" is intercepted
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then an "aws fake" is created for a service then an "aws fake" is deleted
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "aws fake" is created for a service
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then an "aws fake" is deleted then an "operation" is added to an "aws fake"
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "aws fake" is deleted
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then an "operation" is added to an "aws fake" then an "operation" is removed from an "aws fake"
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "operation" is added to an "aws fake"
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then an "operation" is removed from an "aws fake" then a request matching an "aws fake" "operation" is intercepted
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "operation" is removed from an "aws fake"
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then a request matching an "aws fake" "operation" is intercepted then a request for an "operation" not covered by the "aws fake" reaches the provider
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When a request matching an "aws fake" "operation" is intercepted
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request matching a header-filtered "aws fake" "operation" is intercepted then a request for an "operation" not covered by the "aws fake" reaches the provider then an "aws fake" is created for a service
    Given oid in op_status
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then an "aws fake" is created for a service then an "operation" is added to an "aws fake"
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "aws fake" is created for a service
    When an "operation" is added to an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then an "aws fake" is deleted then an "operation" is removed from an "aws fake"
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "aws fake" is deleted
    When an "operation" is removed from an "aws fake"
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then an "operation" is added to an "aws fake" then a request matching an "aws fake" "operation" is intercepted
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "operation" is added to an "aws fake"
    When a request matching an "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then an "operation" is removed from an "aws fake" then a request matching a header-filtered "aws fake" "operation" is intercepted
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When an "operation" is removed from an "aws fake"
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then a request matching an "aws fake" "operation" is intercepted then an "aws fake" is created for a service
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When a request matching an "aws fake" "operation" is intercepted
    When an "aws fake" is created for a service
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service

  @sequence
  Scenario: a request for an "operation" not covered by the "aws fake" reaches the provider then a request matching a header-filtered "aws fake" "operation" is intercepted then an "aws fake" is deleted
    Given fid in fake_status
    When a request for an "operation" not covered by the "aws fake" reaches the provider
    When a request matching a header-filtered "aws fake" "operation" is intercepted
    When an "aws fake" is deleted
    And every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"
    And every "aws fake" is tied to a known service
