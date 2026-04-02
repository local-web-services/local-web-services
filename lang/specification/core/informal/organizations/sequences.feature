@organizations @generated
Feature: Organizations - Action Sequences

  # Generated from FizzBee spec: organizations.fizz
  # Safety invariants: OrgRootConsistency, AccountParentValid, OuParentValid, NoChildOfDeletedOu, TagsOnlyForKnownNodes, PolicyAttachmentTargetValid

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "organizational unit" is created under a parent
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "organizational unit" is deleted
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "account" is created in the "organizations" "organization"
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "account" is moved to a new parent
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "policy" is created
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "policy" is attached to a target
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "policy" is detached from a target
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" resource is tagged
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "organization" is created
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "organizational unit" is deleted
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "account" is created in the "organizations" "organization"
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "account" is moved to a new parent
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "policy" is created
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "policy" is attached to a target
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "policy" is detached from a target
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" resource is tagged
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "organization" is created
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "organizational unit" is created under a parent
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "account" is created in the "organizations" "organization"
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "account" is moved to a new parent
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "policy" is created
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "policy" is attached to a target
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "policy" is detached from a target
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" resource is tagged
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "organization" is created
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "organizational unit" is created under a parent
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "organizational unit" is deleted
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "account" is moved to a new parent
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "policy" is created
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "policy" is attached to a target
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "policy" is detached from a target
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" resource is tagged
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "organization" is created
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "organizational unit" is created under a parent
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "organizational unit" is deleted
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "account" is created in the "organizations" "organization"
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "policy" is created
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "policy" is attached to a target
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "policy" is detached from a target
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" resource is tagged
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "organization" is created
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "organizational unit" is created under a parent
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "organizational unit" is deleted
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "account" is created in the "organizations" "organization"
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "account" is moved to a new parent
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "policy" is attached to a target
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "policy" is detached from a target
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" resource is tagged
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "organization" is created
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "organizational unit" is created under a parent
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "organizational unit" is deleted
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "account" is created in the "organizations" "organization"
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "account" is moved to a new parent
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "policy" is created
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "policy" is detached from a target
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" resource is tagged
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "organization" is created
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "organizational unit" is created under a parent
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "organizational unit" is deleted
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "account" is created in the "organizations" "organization"
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "account" is moved to a new parent
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "policy" is created
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "policy" is attached to a target
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" resource is tagged
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "organization" is created
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "organizational unit" is created under a parent
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "organizational unit" is deleted
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "account" is created in the "organizations" "organization"
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "account" is moved to a new parent
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "policy" is created
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "policy" is attached to a target
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "policy" is detached from a target
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "organizational unit" is created under a parent then an "organizations" "organizational unit" is deleted
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "organizational unit" is deleted then an "organizations" "account" is created in the "organizations" "organization"
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "account" is moved to a new parent
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "account" is moved to a new parent then an "organizations" "policy" is created
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "policy" is created then an "organizations" "policy" is attached to a target
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "policy" is created
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "policy" is attached to a target then an "organizations" "policy" is detached from a target
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "policy" is attached to a target
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" "policy" is detached from a target then an "organizations" resource is tagged
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" "policy" is detached from a target
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organization" is created then an "organizations" resource is tagged then an "organizations" "organizational unit" is created under a parent
    Given 'org-1' not in org_status
    When an "organizations" "organization" is created
    When an "organizations" resource is tagged
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "organization" is created then an "organizations" "account" is created in the "organizations" "organization"
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "organization" is created
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "organizational unit" is deleted then an "organizations" "account" is moved to a new parent
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "policy" is created
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "account" is moved to a new parent then an "organizations" "policy" is attached to a target
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "policy" is created then an "organizations" "policy" is detached from a target
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "policy" is created
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "policy" is attached to a target then an "organizations" resource is tagged
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "policy" is attached to a target
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" "policy" is detached from a target then an "organizations" "organization" is created
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "policy" is detached from a target
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is created under a parent then an "organizations" resource is tagged then an "organizations" "organizational unit" is deleted
    Given 'org-1' in org_status
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" resource is tagged
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "organization" is created then an "organizations" "account" is moved to a new parent
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "organization" is created
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "organizational unit" is created under a parent then an "organizations" "policy" is created
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "policy" is attached to a target
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "account" is moved to a new parent then an "organizations" "policy" is detached from a target
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "policy" is created then an "organizations" resource is tagged
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "policy" is created
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "policy" is attached to a target then an "organizations" "organization" is created
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "policy" is attached to a target
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" "policy" is detached from a target then an "organizations" "organizational unit" is created under a parent
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "policy" is detached from a target
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "organizational unit" is deleted then an "organizations" resource is tagged then an "organizations" "account" is created in the "organizations" "organization"
    Given ou_id in node_status
    When an "organizations" "organizational unit" is deleted
    When an "organizations" resource is tagged
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "organization" is created then an "organizations" "policy" is created
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "organization" is created
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "organizational unit" is created under a parent then an "organizations" "policy" is attached to a target
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "organizational unit" is deleted then an "organizations" "policy" is detached from a target
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "account" is moved to a new parent then an "organizations" resource is tagged
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "account" is moved to a new parent
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "policy" is created then an "organizations" "organization" is created
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "policy" is created
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "policy" is attached to a target then an "organizations" "organizational unit" is created under a parent
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "policy" is attached to a target
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "policy" is detached from a target then an "organizations" "organizational unit" is deleted
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "policy" is detached from a target
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is created in the "organizations" "organization" then an "organizations" resource is tagged then an "organizations" "account" is moved to a new parent
    Given 'org-1' in org_status
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" resource is tagged
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "organization" is created then an "organizations" "policy" is attached to a target
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "organization" is created
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "organizational unit" is created under a parent then an "organizations" "policy" is detached from a target
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "organizational unit" is deleted then an "organizations" resource is tagged
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "organizational unit" is deleted
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "organization" is created
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "policy" is created then an "organizations" "organizational unit" is created under a parent
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "policy" is created
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "policy" is attached to a target then an "organizations" "organizational unit" is deleted
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "policy" is attached to a target
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" "policy" is detached from a target then an "organizations" "account" is created in the "organizations" "organization"
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "policy" is detached from a target
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "account" is moved to a new parent then an "organizations" resource is tagged then an "organizations" "policy" is created
    Given acc_id in node_status
    When an "organizations" "account" is moved to a new parent
    When an "organizations" resource is tagged
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "organization" is created then an "organizations" "policy" is detached from a target
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "organization" is created
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "organizational unit" is created under a parent then an "organizations" resource is tagged
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "organizational unit" is deleted then an "organizations" "organization" is created
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "organizational unit" is created under a parent
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "account" is moved to a new parent then an "organizations" "organizational unit" is deleted
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "policy" is attached to a target then an "organizations" "account" is created in the "organizations" "organization"
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "policy" is attached to a target
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" "policy" is detached from a target then an "organizations" "account" is moved to a new parent
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" "policy" is detached from a target
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is created then an "organizations" resource is tagged then an "organizations" "policy" is attached to a target
    Given 'org-1' in org_status
    When an "organizations" "policy" is created
    When an "organizations" resource is tagged
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "organization" is created then an "organizations" resource is tagged
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "organization" is created
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "organizational unit" is created under a parent then an "organizations" "organization" is created
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "organizational unit" is deleted then an "organizations" "organizational unit" is created under a parent
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "organizational unit" is deleted
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "account" is moved to a new parent then an "organizations" "account" is created in the "organizations" "organization"
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "policy" is created then an "organizations" "account" is moved to a new parent
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "policy" is created
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" "policy" is detached from a target then an "organizations" "policy" is created
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" "policy" is detached from a target
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is attached to a target then an "organizations" resource is tagged then an "organizations" "policy" is detached from a target
    Given pol_id in policy_status
    When an "organizations" "policy" is attached to a target
    When an "organizations" resource is tagged
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "organization" is created then an "organizations" "organizational unit" is created under a parent
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "organization" is created
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "organizational unit" is created under a parent then an "organizations" "organizational unit" is deleted
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "organizational unit" is deleted then an "organizations" "account" is created in the "organizations" "organization"
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "account" is moved to a new parent
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "account" is moved to a new parent then an "organizations" "policy" is created
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "policy" is created then an "organizations" "policy" is attached to a target
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "policy" is created
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" "policy" is attached to a target then an "organizations" resource is tagged
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" "policy" is attached to a target
    When an "organizations" resource is tagged
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" "policy" is detached from a target then an "organizations" resource is tagged then an "organizations" "organization" is created
    Given (pol_id + '#' + target_id) in policy_attached
    When an "organizations" "policy" is detached from a target
    When an "organizations" resource is tagged
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "organization" is created then an "organizations" "organizational unit" is deleted
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "organization" is created
    When an "organizations" "organizational unit" is deleted
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "organizational unit" is created under a parent then an "organizations" "account" is created in the "organizations" "organization"
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "organizational unit" is created under a parent
    When an "organizations" "account" is created in the "organizations" "organization"
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "organizational unit" is deleted then an "organizations" "account" is moved to a new parent
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "organizational unit" is deleted
    When an "organizations" "account" is moved to a new parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "account" is created in the "organizations" "organization" then an "organizations" "policy" is created
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "account" is created in the "organizations" "organization"
    When an "organizations" "policy" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "account" is moved to a new parent then an "organizations" "policy" is attached to a target
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "account" is moved to a new parent
    When an "organizations" "policy" is attached to a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "policy" is created then an "organizations" "policy" is detached from a target
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "policy" is created
    When an "organizations" "policy" is detached from a target
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "policy" is attached to a target then an "organizations" "organization" is created
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "policy" is attached to a target
    When an "organizations" "organization" is created
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"

  @sequence
  Scenario: an "organizations" resource is tagged then an "organizations" "policy" is detached from a target then an "organizations" "organizational unit" is created under a parent
    Given node_id in node_status
    When an "organizations" resource is tagged
    When an "organizations" "policy" is detached from a target
    When an "organizations" "organizational unit" is created under a parent
    And the root was "ACTIVE" whenever the "organizations" "organization" exists
    And every active "organizations" "account" has an "ACTIVE" parent
    And every active "organizations" "organizational unit" has an "ACTIVE" parent
    And no active "organizations" "node" is a child of a "DELETED" "organizations" "organizational unit"
    And "organizations" tags only exist on "organizations" "node"s that are present in the org
    And every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"
