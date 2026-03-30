@organizations @generated
Feature: Organizations - Action Sequences

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @sequence
  Scenario: an organization is created then an organizational unit is created under a parent
    Given 'org-1' not in org_status
    Given an organization has been created
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then an organizational unit is deleted
    Given 'org-1' not in org_status
    Given an organization has been created
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then an account is created in the organization
    Given 'org-1' not in org_status
    Given an organization has been created
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then an account is moved to a new parent
    Given 'org-1' not in org_status
    Given an organization has been created
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then a service control policy is created
    Given 'org-1' not in org_status
    Given an organization has been created
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then a policy is attached to a target
    Given 'org-1' not in org_status
    Given an organization has been created
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then a policy is detached from a target
    Given 'org-1' not in org_status
    Given an organization has been created
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then an organization is created
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then an organizational unit is deleted
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then an account is created in the organization
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then an account is moved to a new parent
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then a service control policy is created
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then a policy is attached to a target
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then a policy is detached from a target
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then an organization is created
    Given ou_id in node_status
    Given an organizational unit has been deleted
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then an organizational unit is created under a parent
    Given ou_id in node_status
    Given an organizational unit has been deleted
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then an account is created in the organization
    Given ou_id in node_status
    Given an organizational unit has been deleted
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then an account is moved to a new parent
    Given ou_id in node_status
    Given an organizational unit has been deleted
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then a service control policy is created
    Given ou_id in node_status
    Given an organizational unit has been deleted
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then a policy is attached to a target
    Given ou_id in node_status
    Given an organizational unit has been deleted
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then a policy is detached from a target
    Given ou_id in node_status
    Given an organizational unit has been deleted
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then an organization is created
    Given 'org-1' in org_status
    Given an account has been created in the organization
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then an organizational unit is created under a parent
    Given 'org-1' in org_status
    Given an account has been created in the organization
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then an organizational unit is deleted
    Given 'org-1' in org_status
    Given an account has been created in the organization
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then an account is moved to a new parent
    Given 'org-1' in org_status
    Given an account has been created in the organization
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then a service control policy is created
    Given 'org-1' in org_status
    Given an account has been created in the organization
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then a policy is attached to a target
    Given 'org-1' in org_status
    Given an account has been created in the organization
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then a policy is detached from a target
    Given 'org-1' in org_status
    Given an account has been created in the organization
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then an organization is created
    Given acc_id in node_status
    Given an account has been moved to a new parent
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then an organizational unit is created under a parent
    Given acc_id in node_status
    Given an account has been moved to a new parent
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then an organizational unit is deleted
    Given acc_id in node_status
    Given an account has been moved to a new parent
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then an account is created in the organization
    Given acc_id in node_status
    Given an account has been moved to a new parent
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then a service control policy is created
    Given acc_id in node_status
    Given an account has been moved to a new parent
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then a policy is attached to a target
    Given acc_id in node_status
    Given an account has been moved to a new parent
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then a policy is detached from a target
    Given acc_id in node_status
    Given an account has been moved to a new parent
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then an organization is created
    Given 'org-1' in org_status
    Given a service control policy has been created
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then an organizational unit is created under a parent
    Given 'org-1' in org_status
    Given a service control policy has been created
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then an organizational unit is deleted
    Given 'org-1' in org_status
    Given a service control policy has been created
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then an account is created in the organization
    Given 'org-1' in org_status
    Given a service control policy has been created
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then an account is moved to a new parent
    Given 'org-1' in org_status
    Given a service control policy has been created
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then a policy is attached to a target
    Given 'org-1' in org_status
    Given a service control policy has been created
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then a policy is detached from a target
    Given 'org-1' in org_status
    Given a service control policy has been created
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then an organization is created
    Given pol_id in policy_status
    Given a policy has been attached to a target
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then an organizational unit is created under a parent
    Given pol_id in policy_status
    Given a policy has been attached to a target
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then an organizational unit is deleted
    Given pol_id in policy_status
    Given a policy has been attached to a target
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then an account is created in the organization
    Given pol_id in policy_status
    Given a policy has been attached to a target
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then an account is moved to a new parent
    Given pol_id in policy_status
    Given a policy has been attached to a target
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then a service control policy is created
    Given pol_id in policy_status
    Given a policy has been attached to a target
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then a policy is detached from a target
    Given pol_id in policy_status
    Given a policy has been attached to a target
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then an organization is created
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then an organizational unit is created under a parent
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then an organizational unit is deleted
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then an account is created in the organization
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then an account is moved to a new parent
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then a service control policy is created
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then a policy is attached to a target
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then an organizational unit is created under a parent then an organizational unit is deleted
    Given 'org-1' not in org_status
    Given an organization has been created
    Given an organizational unit has been created under a parent
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then an organizational unit is deleted then an account is created in the organization
    Given 'org-1' not in org_status
    Given an organization has been created
    Given an organizational unit has been deleted
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then an account is created in the organization then an account is moved to a new parent
    Given 'org-1' not in org_status
    Given an organization has been created
    Given an account has been created in the organization
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then an account is moved to a new parent then a service control policy is created
    Given 'org-1' not in org_status
    Given an organization has been created
    Given an account has been moved to a new parent
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then a service control policy is created then a policy is attached to a target
    Given 'org-1' not in org_status
    Given an organization has been created
    Given a service control policy has been created
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then a policy is attached to a target then a policy is detached from a target
    Given 'org-1' not in org_status
    Given an organization has been created
    Given a policy has been attached to a target
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organization is created then a policy is detached from a target then an organizational unit is created under a parent
    Given 'org-1' not in org_status
    Given an organization has been created
    Given a policy has been detached from a target
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then an organization is created then an account is created in the organization
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    Given an organization has been created
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then an organizational unit is deleted then an account is moved to a new parent
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    Given an organizational unit has been deleted
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then an account is created in the organization then a service control policy is created
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    Given an account has been created in the organization
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then an account is moved to a new parent then a policy is attached to a target
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    Given an account has been moved to a new parent
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then a service control policy is created then a policy is detached from a target
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    Given a service control policy has been created
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then a policy is attached to a target then an organization is created
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    Given a policy has been attached to a target
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is created under a parent then a policy is detached from a target then an organizational unit is deleted
    Given 'org-1' in org_status
    Given an organizational unit has been created under a parent
    Given a policy has been detached from a target
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then an organization is created then an account is moved to a new parent
    Given ou_id in node_status
    Given an organizational unit has been deleted
    Given an organization has been created
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then an organizational unit is created under a parent then a service control policy is created
    Given ou_id in node_status
    Given an organizational unit has been deleted
    Given an organizational unit has been created under a parent
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then an account is created in the organization then a policy is attached to a target
    Given ou_id in node_status
    Given an organizational unit has been deleted
    Given an account has been created in the organization
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then an account is moved to a new parent then a policy is detached from a target
    Given ou_id in node_status
    Given an organizational unit has been deleted
    Given an account has been moved to a new parent
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then a service control policy is created then an organization is created
    Given ou_id in node_status
    Given an organizational unit has been deleted
    Given a service control policy has been created
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then a policy is attached to a target then an organizational unit is created under a parent
    Given ou_id in node_status
    Given an organizational unit has been deleted
    Given a policy has been attached to a target
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an organizational unit is deleted then a policy is detached from a target then an account is created in the organization
    Given ou_id in node_status
    Given an organizational unit has been deleted
    Given a policy has been detached from a target
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then an organization is created then a service control policy is created
    Given 'org-1' in org_status
    Given an account has been created in the organization
    Given an organization has been created
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then an organizational unit is created under a parent then a policy is attached to a target
    Given 'org-1' in org_status
    Given an account has been created in the organization
    Given an organizational unit has been created under a parent
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then an organizational unit is deleted then a policy is detached from a target
    Given 'org-1' in org_status
    Given an account has been created in the organization
    Given an organizational unit has been deleted
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then an account is moved to a new parent then an organization is created
    Given 'org-1' in org_status
    Given an account has been created in the organization
    Given an account has been moved to a new parent
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then a service control policy is created then an organizational unit is created under a parent
    Given 'org-1' in org_status
    Given an account has been created in the organization
    Given a service control policy has been created
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then a policy is attached to a target then an organizational unit is deleted
    Given 'org-1' in org_status
    Given an account has been created in the organization
    Given a policy has been attached to a target
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is created in the organization then a policy is detached from a target then an account is moved to a new parent
    Given 'org-1' in org_status
    Given an account has been created in the organization
    Given a policy has been detached from a target
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then an organization is created then a policy is attached to a target
    Given acc_id in node_status
    Given an account has been moved to a new parent
    Given an organization has been created
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then an organizational unit is created under a parent then a policy is detached from a target
    Given acc_id in node_status
    Given an account has been moved to a new parent
    Given an organizational unit has been created under a parent
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then an organizational unit is deleted then an organization is created
    Given acc_id in node_status
    Given an account has been moved to a new parent
    Given an organizational unit has been deleted
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then an account is created in the organization then an organizational unit is created under a parent
    Given acc_id in node_status
    Given an account has been moved to a new parent
    Given an account has been created in the organization
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then a service control policy is created then an organizational unit is deleted
    Given acc_id in node_status
    Given an account has been moved to a new parent
    Given a service control policy has been created
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then a policy is attached to a target then an account is created in the organization
    Given acc_id in node_status
    Given an account has been moved to a new parent
    Given a policy has been attached to a target
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: an account is moved to a new parent then a policy is detached from a target then a service control policy is created
    Given acc_id in node_status
    Given an account has been moved to a new parent
    Given a policy has been detached from a target
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then an organization is created then a policy is detached from a target
    Given 'org-1' in org_status
    Given a service control policy has been created
    Given an organization has been created
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then an organizational unit is created under a parent then an organization is created
    Given 'org-1' in org_status
    Given a service control policy has been created
    Given an organizational unit has been created under a parent
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then an organizational unit is deleted then an organizational unit is created under a parent
    Given 'org-1' in org_status
    Given a service control policy has been created
    Given an organizational unit has been deleted
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then an account is created in the organization then an organizational unit is deleted
    Given 'org-1' in org_status
    Given a service control policy has been created
    Given an account has been created in the organization
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then an account is moved to a new parent then an account is created in the organization
    Given 'org-1' in org_status
    Given a service control policy has been created
    Given an account has been moved to a new parent
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then a policy is attached to a target then an account is moved to a new parent
    Given 'org-1' in org_status
    Given a service control policy has been created
    Given a policy has been attached to a target
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a service control policy is created then a policy is detached from a target then a policy is attached to a target
    Given 'org-1' in org_status
    Given a service control policy has been created
    Given a policy has been detached from a target
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then an organization is created then an organizational unit is created under a parent
    Given pol_id in policy_status
    Given a policy has been attached to a target
    Given an organization has been created
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then an organizational unit is created under a parent then an organizational unit is deleted
    Given pol_id in policy_status
    Given a policy has been attached to a target
    Given an organizational unit has been created under a parent
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then an organizational unit is deleted then an account is created in the organization
    Given pol_id in policy_status
    Given a policy has been attached to a target
    Given an organizational unit has been deleted
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then an account is created in the organization then an account is moved to a new parent
    Given pol_id in policy_status
    Given a policy has been attached to a target
    Given an account has been created in the organization
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then an account is moved to a new parent then a service control policy is created
    Given pol_id in policy_status
    Given a policy has been attached to a target
    Given an account has been moved to a new parent
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then a service control policy is created then a policy is detached from a target
    Given pol_id in policy_status
    Given a policy has been attached to a target
    Given a service control policy has been created
    When a policy is detached from a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is attached to a target then a policy is detached from a target then an organization is created
    Given pol_id in policy_status
    Given a policy has been attached to a target
    Given a policy has been detached from a target
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then an organization is created then an organizational unit is deleted
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    Given an organization has been created
    When an organizational unit is deleted
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then an organizational unit is created under a parent then an account is created in the organization
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    Given an organizational unit has been created under a parent
    When an account is created in the organization
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then an organizational unit is deleted then an account is moved to a new parent
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    Given an organizational unit has been deleted
    When an account is moved to a new parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then an account is created in the organization then a service control policy is created
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    Given an account has been created in the organization
    When a service control policy is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then an account is moved to a new parent then a policy is attached to a target
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    Given an account has been moved to a new parent
    When a policy is attached to a target
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then a service control policy is created then an organization is created
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    Given a service control policy has been created
    When an organization is created
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @sequence
  Scenario: a policy is detached from a target then a policy is attached to a target then an organizational unit is created under a parent
    Given (pol_id + '#' + target_id) in policy_attached
    Given a policy has been detached from a target
    Given a policy has been attached to a target
    When an organizational unit is created under a parent
    Then the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node
