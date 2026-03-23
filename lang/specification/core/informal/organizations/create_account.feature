@organizations @generated
Feature: Organizations - An Account Is Created In The Organization

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @create_account
  Scenario: an account is created in the organization
    Given the organization exists
    And the account does not already exist
    When an account is created in the organization
    Then the account is "ACTIVE" under the root
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @standard @negative @create_account
  Scenario: an account is created in the organization fails when the organization does not exist
    Given the organization does not exist
    When an account is created in the organization
    Then the operation is rejected

  @standard @negative @create_account
  Scenario: an account is created in the organization fails when the account already exists
    Given the organization exists
    And the account already exists
    When an account is created in the organization
    Then the operation is rejected
