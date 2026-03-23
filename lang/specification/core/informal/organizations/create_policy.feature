@organizations @generated
Feature: Organizations - A Service Control Policy Is Created

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @create_policy
  Scenario: a service control policy is created
    Given the organization exists
    And the policy does not already exist
    When a service control policy is created
    Then the policy is "ACTIVE"
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @standard @negative @create_policy
  Scenario: a service control policy is created fails when the organization does not exist
    Given the organization does not exist
    When a service control policy is created
    Then the operation is rejected

  @standard @negative @create_policy
  Scenario: a service control policy is created fails when the policy already exists
    Given the organization exists
    And the policy already exists
    When a service control policy is created
    Then the operation is rejected
