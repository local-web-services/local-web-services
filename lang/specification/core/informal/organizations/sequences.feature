@organizations @generated
Feature: Organizations - Action Sequences

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: an organization is created then an organizational unit is created under a parent
    Given 'org-1' not in org_status
    When an organization is created
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then an organizational unit is deleted
    Given 'org-1' not in org_status
    When an organization is created
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then an account is created in the organization
    Given 'org-1' not in org_status
    When an organization is created
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then an account is moved to a new parent
    Given 'org-1' not in org_status
    When an organization is created
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then a service control policy is created
    Given 'org-1' not in org_status
    When an organization is created
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then a policy is attached to a target
    Given 'org-1' not in org_status
    When an organization is created
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then a policy is detached from a target
    Given 'org-1' not in org_status
    When an organization is created
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then an organization is created
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then an organizational unit is deleted
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then an account is created in the organization
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then an account is moved to a new parent
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then a service control policy is created
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then a policy is attached to a target
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then a policy is detached from a target
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then an organization is created
    Given ou_id in node_status
    When an organizational unit is deleted
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then an organizational unit is created under a parent
    Given ou_id in node_status
    When an organizational unit is deleted
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then an account is created in the organization
    Given ou_id in node_status
    When an organizational unit is deleted
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then an account is moved to a new parent
    Given ou_id in node_status
    When an organizational unit is deleted
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then a service control policy is created
    Given ou_id in node_status
    When an organizational unit is deleted
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then a policy is attached to a target
    Given ou_id in node_status
    When an organizational unit is deleted
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then a policy is detached from a target
    Given ou_id in node_status
    When an organizational unit is deleted
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then an organization is created
    Given 'org-1' in org_status
    When an account is created in the organization
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then an organizational unit is created under a parent
    Given 'org-1' in org_status
    When an account is created in the organization
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then an organizational unit is deleted
    Given 'org-1' in org_status
    When an account is created in the organization
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then an account is moved to a new parent
    Given 'org-1' in org_status
    When an account is created in the organization
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then a service control policy is created
    Given 'org-1' in org_status
    When an account is created in the organization
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then a policy is attached to a target
    Given 'org-1' in org_status
    When an account is created in the organization
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then a policy is detached from a target
    Given 'org-1' in org_status
    When an account is created in the organization
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then an organization is created
    Given acc_id in node_status
    When an account is moved to a new parent
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then an organizational unit is created under a parent
    Given acc_id in node_status
    When an account is moved to a new parent
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then an organizational unit is deleted
    Given acc_id in node_status
    When an account is moved to a new parent
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then an account is created in the organization
    Given acc_id in node_status
    When an account is moved to a new parent
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then a service control policy is created
    Given acc_id in node_status
    When an account is moved to a new parent
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then a policy is attached to a target
    Given acc_id in node_status
    When an account is moved to a new parent
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then a policy is detached from a target
    Given acc_id in node_status
    When an account is moved to a new parent
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then an organization is created
    Given 'org-1' in org_status
    When a service control policy is created
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then an organizational unit is created under a parent
    Given 'org-1' in org_status
    When a service control policy is created
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then an organizational unit is deleted
    Given 'org-1' in org_status
    When a service control policy is created
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then an account is created in the organization
    Given 'org-1' in org_status
    When a service control policy is created
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then an account is moved to a new parent
    Given 'org-1' in org_status
    When a service control policy is created
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then a policy is attached to a target
    Given 'org-1' in org_status
    When a service control policy is created
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then a policy is detached from a target
    Given 'org-1' in org_status
    When a service control policy is created
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then an organization is created
    Given pol_id in policy_status
    When a policy is attached to a target
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then an organizational unit is created under a parent
    Given pol_id in policy_status
    When a policy is attached to a target
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then an organizational unit is deleted
    Given pol_id in policy_status
    When a policy is attached to a target
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then an account is created in the organization
    Given pol_id in policy_status
    When a policy is attached to a target
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then an account is moved to a new parent
    Given pol_id in policy_status
    When a policy is attached to a target
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then a service control policy is created
    Given pol_id in policy_status
    When a policy is attached to a target
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then a policy is detached from a target
    Given pol_id in policy_status
    When a policy is attached to a target
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then an organization is created
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then an organizational unit is created under a parent
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then an organizational unit is deleted
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then an account is created in the organization
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then an account is moved to a new parent
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then a service control policy is created
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then a policy is attached to a target
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then an organizational unit is created under a parent then an organizational unit is deleted
    Given 'org-1' not in org_status
    When an organization is created
    When an organizational unit is created under a parent
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then an organizational unit is deleted then an account is created in the organization
    Given 'org-1' not in org_status
    When an organization is created
    When an organizational unit is deleted
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then an account is created in the organization then an account is moved to a new parent
    Given 'org-1' not in org_status
    When an organization is created
    When an account is created in the organization
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then an account is moved to a new parent then a service control policy is created
    Given 'org-1' not in org_status
    When an organization is created
    When an account is moved to a new parent
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then a service control policy is created then a policy is attached to a target
    Given 'org-1' not in org_status
    When an organization is created
    When a service control policy is created
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then a policy is attached to a target then a policy is detached from a target
    Given 'org-1' not in org_status
    When an organization is created
    When a policy is attached to a target
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organization is created then a policy is detached from a target then an organizational unit is created under a parent
    Given 'org-1' not in org_status
    When an organization is created
    When a policy is detached from a target
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then an organization is created then an account is created in the organization
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When an organization is created
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then an organizational unit is deleted then an account is moved to a new parent
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When an organizational unit is deleted
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then an account is created in the organization then a service control policy is created
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When an account is created in the organization
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then an account is moved to a new parent then a policy is attached to a target
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When an account is moved to a new parent
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then a service control policy is created then a policy is detached from a target
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When a service control policy is created
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then a policy is attached to a target then an organization is created
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When a policy is attached to a target
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is created under a parent then a policy is detached from a target then an organizational unit is deleted
    Given 'org-1' in org_status
    When an organizational unit is created under a parent
    When a policy is detached from a target
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then an organization is created then an account is moved to a new parent
    Given ou_id in node_status
    When an organizational unit is deleted
    When an organization is created
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then an organizational unit is created under a parent then a service control policy is created
    Given ou_id in node_status
    When an organizational unit is deleted
    When an organizational unit is created under a parent
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then an account is created in the organization then a policy is attached to a target
    Given ou_id in node_status
    When an organizational unit is deleted
    When an account is created in the organization
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then an account is moved to a new parent then a policy is detached from a target
    Given ou_id in node_status
    When an organizational unit is deleted
    When an account is moved to a new parent
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then a service control policy is created then an organization is created
    Given ou_id in node_status
    When an organizational unit is deleted
    When a service control policy is created
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then a policy is attached to a target then an organizational unit is created under a parent
    Given ou_id in node_status
    When an organizational unit is deleted
    When a policy is attached to a target
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an organizational unit is deleted then a policy is detached from a target then an account is created in the organization
    Given ou_id in node_status
    When an organizational unit is deleted
    When a policy is detached from a target
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then an organization is created then a service control policy is created
    Given 'org-1' in org_status
    When an account is created in the organization
    When an organization is created
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then an organizational unit is created under a parent then a policy is attached to a target
    Given 'org-1' in org_status
    When an account is created in the organization
    When an organizational unit is created under a parent
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then an organizational unit is deleted then a policy is detached from a target
    Given 'org-1' in org_status
    When an account is created in the organization
    When an organizational unit is deleted
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then an account is moved to a new parent then an organization is created
    Given 'org-1' in org_status
    When an account is created in the organization
    When an account is moved to a new parent
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then a service control policy is created then an organizational unit is created under a parent
    Given 'org-1' in org_status
    When an account is created in the organization
    When a service control policy is created
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then a policy is attached to a target then an organizational unit is deleted
    Given 'org-1' in org_status
    When an account is created in the organization
    When a policy is attached to a target
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is created in the organization then a policy is detached from a target then an account is moved to a new parent
    Given 'org-1' in org_status
    When an account is created in the organization
    When a policy is detached from a target
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then an organization is created then a policy is attached to a target
    Given acc_id in node_status
    When an account is moved to a new parent
    When an organization is created
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then an organizational unit is created under a parent then a policy is detached from a target
    Given acc_id in node_status
    When an account is moved to a new parent
    When an organizational unit is created under a parent
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then an organizational unit is deleted then an organization is created
    Given acc_id in node_status
    When an account is moved to a new parent
    When an organizational unit is deleted
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then an account is created in the organization then an organizational unit is created under a parent
    Given acc_id in node_status
    When an account is moved to a new parent
    When an account is created in the organization
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then a service control policy is created then an organizational unit is deleted
    Given acc_id in node_status
    When an account is moved to a new parent
    When a service control policy is created
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then a policy is attached to a target then an account is created in the organization
    Given acc_id in node_status
    When an account is moved to a new parent
    When a policy is attached to a target
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: an account is moved to a new parent then a policy is detached from a target then a service control policy is created
    Given acc_id in node_status
    When an account is moved to a new parent
    When a policy is detached from a target
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then an organization is created then a policy is detached from a target
    Given 'org-1' in org_status
    When a service control policy is created
    When an organization is created
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then an organizational unit is created under a parent then an organization is created
    Given 'org-1' in org_status
    When a service control policy is created
    When an organizational unit is created under a parent
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then an organizational unit is deleted then an organizational unit is created under a parent
    Given 'org-1' in org_status
    When a service control policy is created
    When an organizational unit is deleted
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then an account is created in the organization then an organizational unit is deleted
    Given 'org-1' in org_status
    When a service control policy is created
    When an account is created in the organization
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then an account is moved to a new parent then an account is created in the organization
    Given 'org-1' in org_status
    When a service control policy is created
    When an account is moved to a new parent
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then a policy is attached to a target then an account is moved to a new parent
    Given 'org-1' in org_status
    When a service control policy is created
    When a policy is attached to a target
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a service control policy is created then a policy is detached from a target then a policy is attached to a target
    Given 'org-1' in org_status
    When a service control policy is created
    When a policy is detached from a target
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then an organization is created then an organizational unit is created under a parent
    Given pol_id in policy_status
    When a policy is attached to a target
    When an organization is created
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then an organizational unit is created under a parent then an organizational unit is deleted
    Given pol_id in policy_status
    When a policy is attached to a target
    When an organizational unit is created under a parent
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then an organizational unit is deleted then an account is created in the organization
    Given pol_id in policy_status
    When a policy is attached to a target
    When an organizational unit is deleted
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then an account is created in the organization then an account is moved to a new parent
    Given pol_id in policy_status
    When a policy is attached to a target
    When an account is created in the organization
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then an account is moved to a new parent then a service control policy is created
    Given pol_id in policy_status
    When a policy is attached to a target
    When an account is moved to a new parent
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then a service control policy is created then a policy is detached from a target
    Given pol_id in policy_status
    When a policy is attached to a target
    When a service control policy is created
    When a policy is detached from a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is attached to a target then a policy is detached from a target then an organization is created
    Given pol_id in policy_status
    When a policy is attached to a target
    When a policy is detached from a target
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then an organization is created then an organizational unit is deleted
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When an organization is created
    When an organizational unit is deleted
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then an organizational unit is created under a parent then an account is created in the organization
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When an organizational unit is created under a parent
    When an account is created in the organization
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then an organizational unit is deleted then an account is moved to a new parent
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When an organizational unit is deleted
    When an account is moved to a new parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then an account is created in the organization then a service control policy is created
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When an account is created in the organization
    When a service control policy is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then an account is moved to a new parent then a policy is attached to a target
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When an account is moved to a new parent
    When a policy is attached to a target
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then a service control policy is created then an organization is created
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When a service control policy is created
    When an organization is created
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node

  @exhaustive @sequence
  Scenario: a policy is detached from a target then a policy is attached to a target then an organizational unit is created under a parent
    Given (pol_id + '#' + target_id) in policy_attached
    When a policy is detached from a target
    When a policy is attached to a target
    When an organizational unit is created under a parent
    And the root is "ACTIVE" whenever the organization exists
    And every active account has an "ACTIVE" parent
    And every active organizational unit has an "ACTIVE" parent
    And no active node is a child of a deleted organizational unit
    And every active policy attachment targets an "ACTIVE" node
