@organizations @generated
Feature: Organizations - An Organization Is Created

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @create_organization
  Scenario: an organization is created
    Given the organization does not already exist
    When an organization is created
    Then the organization and its root exist
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @standard @negative @create_organization
  Scenario: an organization is created fails when the organization already exists
    Given the organization already exists
    When an organization is created
    Then the operation is rejected
