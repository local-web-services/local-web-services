@organizations @generated
Feature: Organizations - An Account Is Moved To A New Parent

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @minimal @happy @move_account
  Scenario: an account is moved to a new parent
    Given the account exists and is "ACTIVE"
    And the source parent matches the account's current parent
    And the destination parent is "ACTIVE"
    When an account is moved to a new parent
    Then the account is under the new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @guard @negative @move_account
  Scenario: an account is moved to a new parent fails when the account does not exist or is not "ACTIVE"
    Given the account does not exist or is not "ACTIVE"
    When an account is moved to a new parent
    Then the operation is rejected

  @guard @negative @move_account
  Scenario: an account is moved to a new parent fails when the source parent does not match the account's current parent
    Given the account exists and is "ACTIVE"
    And the source parent does not match the account's current parent
    When an account is moved to a new parent
    Then the operation is rejected

  @guard @negative @move_account
  Scenario: an account is moved to a new parent fails when the destination parent is not "ACTIVE"
    Given the account exists and is "ACTIVE"
    And the source parent matches the account's current parent
    And the destination parent is not "ACTIVE"
    When an account is moved to a new parent
    Then the operation is rejected
