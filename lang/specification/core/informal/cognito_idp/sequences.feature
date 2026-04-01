@cognitoidp @generated
Feature: CognitoIdp - Action Sequences

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user pool" is deleted
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" is deleted by an admin
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin confirms a "cognito" "user" registration
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin resets a "cognito" "user" password
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin sets a "cognito" "user" password
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" was "DISABLED" by an admin
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" was "ENABLED" by an admin
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin updates attributes for a confirmed user
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" is marked as compromised
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "group" is created in an active "cognito" "user pool"
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "group" is deleted
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin removes a "cognito" "user" from a "cognito" "group"
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a confirmed enabled user initiates authentication
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" responds to an auth challenge
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an authenticated session expires
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a verification code delivery fails for an unconfirmed user
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user pool" is created
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" is deleted by an admin
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin confirms a "cognito" "user" registration
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin resets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin sets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" was "DISABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" was "ENABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" is marked as compromised
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "group" is created in an active "cognito" "user pool"
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "group" is deleted
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin removes a "cognito" "user" from a "cognito" "group"
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" responds to an auth challenge
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an authenticated session expires
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user pool" is created
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user pool" is deleted
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" is deleted by an admin
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin confirms a "cognito" "user" registration
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin resets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin sets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" was "DISABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" was "ENABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" is marked as compromised
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "group" is created in an active "cognito" "user pool"
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "group" is deleted
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin removes a "cognito" "user" from a "cognito" "group"
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" responds to an auth challenge
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an authenticated session expires
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user pool" is created
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "group" is deleted
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an authenticated session expires
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an authenticated session expires
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an authenticated session expires
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an authenticated session expires
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user pool" is created
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user pool" is deleted
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" is deleted by an admin
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin confirms a "cognito" "user" registration
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin resets a "cognito" "user" password
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin sets a "cognito" "user" password
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin updates attributes for a confirmed user
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" is marked as compromised
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "group" is deleted
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a confirmed enabled user initiates authentication
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" responds to an auth challenge
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an authenticated session expires
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user pool" is created
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user pool" is deleted
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" is deleted by an admin
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin confirms a "cognito" "user" registration
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin resets a "cognito" "user" password
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin sets a "cognito" "user" password
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin updates attributes for a confirmed user
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" is marked as compromised
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "group" is deleted
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a confirmed enabled user initiates authentication
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" responds to an auth challenge
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an authenticated session expires
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an authenticated session expires
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user pool" is created
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "group" is deleted
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an authenticated session expires
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user pool" is created
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user pool" is deleted
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" is deleted by an admin
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin confirms a "cognito" "user" registration
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin resets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin sets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" was "DISABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" was "ENABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" is marked as compromised
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "group" is deleted
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin removes a "cognito" "user" from a "cognito" "group"
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" responds to an auth challenge
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an authenticated session expires
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user pool" is created
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user pool" is deleted
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" is deleted by an admin
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin confirms a "cognito" "user" registration
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin resets a "cognito" "user" password
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin sets a "cognito" "user" password
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" was "DISABLED" by an admin
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" was "ENABLED" by an admin
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin updates attributes for a confirmed user
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" is marked as compromised
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "group" is created in an active "cognito" "user pool"
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin removes a "cognito" "user" from a "cognito" "group"
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a confirmed enabled user initiates authentication
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" responds to an auth challenge
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin initiates authentication on behalf of a confirmed enabled user
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an authenticated session expires
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a verification code delivery fails for an unconfirmed user
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an authenticated session expires
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an authenticated session expires
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user pool" is created
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "group" is deleted
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an authenticated session expires
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user pool" is created
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user pool" is deleted
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user" is deleted by an admin
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin confirms a "cognito" "user" registration
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin resets a "cognito" "user" password
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin sets a "cognito" "user" password
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user" was "DISABLED" by an admin
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user" was "ENABLED" by an admin
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin updates attributes for a confirmed user
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user" is marked as compromised
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "group" is created in an active "cognito" "user pool"
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "group" is deleted
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin removes a "cognito" "user" from a "cognito" "group"
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a confirmed enabled user initiates authentication
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin initiates authentication on behalf of a confirmed enabled user
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an authenticated session expires
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a verification code delivery fails for an unconfirmed user
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an authenticated session expires
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user pool" is created
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user pool" is deleted
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" is deleted by an admin
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin confirms a "cognito" "user" registration
    Given session_id in session_status
    When an authenticated session expires
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin resets a "cognito" "user" password
    Given session_id in session_status
    When an authenticated session expires
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin sets a "cognito" "user" password
    Given session_id in session_status
    When an authenticated session expires
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" was "DISABLED" by an admin
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" was "ENABLED" by an admin
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin updates attributes for a confirmed user
    Given session_id in session_status
    When an authenticated session expires
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" is marked as compromised
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "group" is created in an active "cognito" "user pool"
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "group" is deleted
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given session_id in session_status
    When an authenticated session expires
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin removes a "cognito" "user" from a "cognito" "group"
    Given session_id in session_status
    When an authenticated session expires
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a confirmed enabled user initiates authentication
    Given session_id in session_status
    When an authenticated session expires
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" responds to an auth challenge
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin initiates authentication on behalf of a confirmed enabled user
    Given session_id in session_status
    When an authenticated session expires
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a verification code delivery fails for an unconfirmed user
    Given session_id in session_status
    When an authenticated session expires
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user pool" is created
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "group" is deleted
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an authenticated session expires
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user pool" is deleted then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" is deleted by an admin
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" is deleted by an admin then an admin confirms a "cognito" "user" registration
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" is deleted by an admin
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin confirms a "cognito" "user" registration then an admin resets a "cognito" "user" password
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin confirms a "cognito" "user" registration
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin resets a "cognito" "user" password then an admin sets a "cognito" "user" password
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin resets a "cognito" "user" password
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin sets a "cognito" "user" password then a "cognito" "user" was "DISABLED" by an admin
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" was "ENABLED" by an admin
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" was "ENABLED" by an admin then an admin updates attributes for a confirmed user
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin updates attributes for a confirmed user then a "cognito" "user" is marked as compromised
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" is marked as compromised then a "cognito" "group" is created in an active "cognito" "user pool"
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" is marked as compromised
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "group" is deleted
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "group" is deleted then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "group" is deleted
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin removes a "cognito" "user" from a "cognito" "group"
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin removes a "cognito" "user" from a "cognito" "group" then a confirmed enabled user initiates authentication
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a confirmed enabled user initiates authentication then a "cognito" "user" responds to an auth challenge
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a "cognito" "user" responds to an auth challenge then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a "cognito" "user" responds to an auth challenge
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an admin initiates authentication on behalf of a confirmed enabled user then an authenticated session expires
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then an authenticated session expires then a verification code delivery fails for an unconfirmed user
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When an authenticated session expires
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is created then a verification code delivery fails for an unconfirmed user then a "cognito" "user pool" is deleted
    Given pool_id not in pool_status
    When a "cognito" "user pool" is created
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user pool" is created then a "cognito" "user" is deleted by an admin
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user pool" is created
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin confirms a "cognito" "user" registration
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" is deleted by an admin then an admin resets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" is deleted by an admin
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin confirms a "cognito" "user" registration then an admin sets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin confirms a "cognito" "user" registration
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin resets a "cognito" "user" password then a "cognito" "user" was "DISABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin sets a "cognito" "user" password then a "cognito" "user" was "ENABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" was "DISABLED" by an admin then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" is marked as compromised
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin updates attributes for a confirmed user then a "cognito" "group" is created in an active "cognito" "user pool"
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin updates attributes for a confirmed user
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" is marked as compromised then a "cognito" "group" is deleted
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" is marked as compromised
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "group" is created in an active "cognito" "user pool" then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "group" is deleted then an admin removes a "cognito" "user" from a "cognito" "group"
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "group" is deleted
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" responds to an auth challenge
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a confirmed enabled user initiates authentication then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a confirmed enabled user initiates authentication
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a "cognito" "user" responds to an auth challenge then an authenticated session expires
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" responds to an auth challenge
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an admin initiates authentication on behalf of a confirmed enabled user then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then an authenticated session expires then a "cognito" "user pool" is created
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When an authenticated session expires
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user pool" is deleted then a verification code delivery fails for an unconfirmed user then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given pool_id in pool_status
    When a "cognito" "user pool" is deleted
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user pool" is created then an admin confirms a "cognito" "user" registration
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user pool" is created
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user pool" is deleted then an admin resets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user pool" is deleted
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" is deleted by an admin then an admin sets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" is deleted by an admin
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin confirms a "cognito" "user" registration then a "cognito" "user" was "DISABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin resets a "cognito" "user" password then a "cognito" "user" was "ENABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin sets a "cognito" "user" password then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin sets a "cognito" "user" password
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" is marked as compromised
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" was "ENABLED" by an admin then a "cognito" "group" is created in an active "cognito" "user pool"
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin updates attributes for a confirmed user then a "cognito" "group" is deleted
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin updates attributes for a confirmed user
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" is marked as compromised then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" is marked as compromised
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "group" is created in an active "cognito" "user pool" then an admin removes a "cognito" "user" from a "cognito" "group"
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "group" is deleted then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "group" is deleted
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" responds to an auth challenge
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin removes a "cognito" "user" from a "cognito" "group" then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a confirmed enabled user initiates authentication then an authenticated session expires
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a confirmed enabled user initiates authentication
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" responds to an auth challenge then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" responds to an auth challenge
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user pool" is created
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an authenticated session expires then a "cognito" "user pool" is deleted
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an authenticated session expires
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a verification code delivery fails for an unconfirmed user then a "cognito" "user" is deleted by an admin
    Given pool_id in pool_status
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user pool" is created then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user pool" is created
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user pool" is deleted then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user pool" is deleted
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin confirms a "cognito" "user" registration then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin resets a "cognito" "user" password then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin resets a "cognito" "user" password
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin sets a "cognito" "user" password then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user" was "DISABLED" by an admin then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user" was "ENABLED" by an admin then a "cognito" "group" is deleted
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin updates attributes for a confirmed user then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin updates attributes for a confirmed user
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user" is marked as compromised then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" is marked as compromised
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "group" is created in an active "cognito" "user pool" then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "group" is deleted then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "group" is deleted
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin removes a "cognito" "user" from a "cognito" "group" then an authenticated session expires
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a confirmed enabled user initiates authentication then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a confirmed enabled user initiates authentication
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a "cognito" "user" responds to an auth challenge then a "cognito" "user pool" is created
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then an authenticated session expires then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When an authenticated session expires
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is deleted by an admin then a verification code delivery fails for an unconfirmed user then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When a "cognito" "user" is deleted by an admin
    When a verification code delivery fails for an unconfirmed user
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user pool" is created then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user pool" is created
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user pool" is deleted then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" is deleted by an admin then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" is deleted by an admin
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin resets a "cognito" "user" password then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin sets a "cognito" "user" password then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin sets a "cognito" "user" password
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" was "DISABLED" by an admin then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" was "ENABLED" by an admin then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin updates attributes for a confirmed user then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin updates attributes for a confirmed user
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" is marked as compromised then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" is marked as compromised
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "group" is deleted then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "group" is deleted
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an authenticated session expires
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin removes a "cognito" "user" from a "cognito" "group" then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a confirmed enabled user initiates authentication then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a confirmed enabled user initiates authentication
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a "cognito" "user" responds to an auth challenge then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then an authenticated session expires then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When an authenticated session expires
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin confirms a "cognito" "user" registration then a verification code delivery fails for an unconfirmed user then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin confirms a "cognito" "user" registration
    When a verification code delivery fails for an unconfirmed user
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user pool" is created then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user pool" is created
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user pool" is deleted then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" is deleted by an admin then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin confirms a "cognito" "user" registration then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin sets a "cognito" "user" password then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin sets a "cognito" "user" password
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" was "DISABLED" by an admin then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" was "ENABLED" by an admin then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin updates attributes for a confirmed user then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin updates attributes for a confirmed user
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" is marked as compromised then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "group" is created in an active "cognito" "user pool" then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "group" is deleted then an authenticated session expires
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "group" is deleted
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a confirmed enabled user initiates authentication then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a confirmed enabled user initiates authentication
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a "cognito" "user" responds to an auth challenge then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then an authenticated session expires then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When an authenticated session expires
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin resets a "cognito" "user" password then a verification code delivery fails for an unconfirmed user then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin resets a "cognito" "user" password
    When a verification code delivery fails for an unconfirmed user
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user pool" is created then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user pool" is created
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user pool" is deleted then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user pool" is deleted
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" is deleted by an admin then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin confirms a "cognito" "user" registration then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin resets a "cognito" "user" password then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin resets a "cognito" "user" password
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" was "DISABLED" by an admin then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" was "ENABLED" by an admin then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" was "ENABLED" by an admin
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin updates attributes for a confirmed user then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" is marked as compromised then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" is marked as compromised
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "group" is created in an active "cognito" "user pool" then an authenticated session expires
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "group" is deleted then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "group" is deleted
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a confirmed enabled user initiates authentication then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a "cognito" "user" responds to an auth challenge then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an admin initiates authentication on behalf of a confirmed enabled user then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then an authenticated session expires then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When an authenticated session expires
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin sets a "cognito" "user" password then a verification code delivery fails for an unconfirmed user then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin sets a "cognito" "user" password
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user pool" is created then an admin updates attributes for a confirmed user
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user pool" is created
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user pool" is deleted then a "cognito" "user" is marked as compromised
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" is deleted by an admin then a "cognito" "group" is deleted
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin confirms a "cognito" "user" registration then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin confirms a "cognito" "user" registration
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin resets a "cognito" "user" password then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin resets a "cognito" "user" password
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin sets a "cognito" "user" password then a confirmed enabled user initiates authentication
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin sets a "cognito" "user" password
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" responds to an auth challenge
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin updates attributes for a confirmed user then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin updates attributes for a confirmed user
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" is marked as compromised then an authenticated session expires
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" is marked as compromised
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "group" is created in an active "cognito" "user pool" then a verification code delivery fails for an unconfirmed user
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "group" is deleted then a "cognito" "user pool" is created
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "group" is deleted
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user pool" is deleted
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a confirmed enabled user initiates authentication then a "cognito" "user" is deleted by an admin
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" responds to an auth challenge then an admin confirms a "cognito" "user" registration
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" responds to an auth challenge
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an admin initiates authentication on behalf of a confirmed enabled user then an admin resets a "cognito" "user" password
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then an authenticated session expires then an admin sets a "cognito" "user" password
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When an authenticated session expires
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "DISABLED" by an admin then a verification code delivery fails for an unconfirmed user then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_enabled
    When a "cognito" "user" was "DISABLED" by an admin
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user pool" is created then a "cognito" "user" is marked as compromised
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user pool" is created
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user pool" is deleted then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user pool" is deleted
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "group" is deleted
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" is deleted by an admin then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" is deleted by an admin
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin confirms a "cognito" "user" registration then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin confirms a "cognito" "user" registration
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin resets a "cognito" "user" password then a confirmed enabled user initiates authentication
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin resets a "cognito" "user" password
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin sets a "cognito" "user" password then a "cognito" "user" responds to an auth challenge
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" was "DISABLED" by an admin then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin updates attributes for a confirmed user then an authenticated session expires
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin updates attributes for a confirmed user
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" is marked as compromised then a verification code delivery fails for an unconfirmed user
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" is marked as compromised
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user pool" is created
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "group" is deleted then a "cognito" "user pool" is deleted
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "group" is deleted
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" is deleted by an admin
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a confirmed enabled user initiates authentication then an admin confirms a "cognito" "user" registration
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a confirmed enabled user initiates authentication
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" responds to an auth challenge then an admin resets a "cognito" "user" password
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" responds to an auth challenge
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an admin initiates authentication on behalf of a confirmed enabled user then an admin sets a "cognito" "user" password
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then an authenticated session expires then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When an authenticated session expires
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" was "ENABLED" by an admin then a verification code delivery fails for an unconfirmed user then an admin updates attributes for a confirmed user
    Given user_id in user_enabled
    When a "cognito" "user" was "ENABLED" by an admin
    When a verification code delivery fails for an unconfirmed user
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user pool" is created then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user pool" is created
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user pool" is deleted then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user pool" is deleted
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" is deleted by an admin then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" is deleted by an admin
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin confirms a "cognito" "user" registration then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin confirms a "cognito" "user" registration
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin resets a "cognito" "user" password then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin sets a "cognito" "user" password then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin sets a "cognito" "user" password
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" was "DISABLED" by an admin then an authenticated session expires
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" was "DISABLED" by an admin
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" was "ENABLED" by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" was "ENABLED" by an admin
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" is marked as compromised then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "group" is deleted then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "group" is deleted
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin removes a "cognito" "user" from a "cognito" "group" then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a confirmed enabled user initiates authentication then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a confirmed enabled user initiates authentication
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a "cognito" "user" responds to an auth challenge then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" responds to an auth challenge
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then an authenticated session expires then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When an authenticated session expires
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin updates attributes for a confirmed user then a verification code delivery fails for an unconfirmed user then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin updates attributes for a confirmed user
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user pool" is created then a "cognito" "group" is deleted
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user pool" is created
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user pool" is deleted then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user pool" is deleted
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user" is deleted by an admin then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" is deleted by an admin
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin confirms a "cognito" "user" registration then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin resets a "cognito" "user" password then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin resets a "cognito" "user" password
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin sets a "cognito" "user" password then an authenticated session expires
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin sets a "cognito" "user" password
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user" was "DISABLED" by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" was "DISABLED" by an admin
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user pool" is created
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin updates attributes for a confirmed user then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin updates attributes for a confirmed user
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "group" is deleted then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "group" is deleted
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin removes a "cognito" "user" from a "cognito" "group" then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a confirmed enabled user initiates authentication then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a confirmed enabled user initiates authentication
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a "cognito" "user" responds to an auth challenge then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then an authenticated session expires then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When an authenticated session expires
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" is marked as compromised then a verification code delivery fails for an unconfirmed user then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When a "cognito" "user" is marked as compromised
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user pool" is created then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user pool" is created
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user pool" is deleted then an admin removes a "cognito" "user" from a "cognito" "group"
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user pool" is deleted
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" is deleted by an admin then a "cognito" "user" responds to an auth challenge
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin confirms a "cognito" "user" registration then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin confirms a "cognito" "user" registration
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin resets a "cognito" "user" password then an authenticated session expires
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin resets a "cognito" "user" password
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin sets a "cognito" "user" password then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin sets a "cognito" "user" password
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user pool" is created
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user pool" is deleted
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin updates attributes for a confirmed user then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" is marked as compromised then a "cognito" "user" is deleted by an admin
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "group" is deleted then an admin confirms a "cognito" "user" registration
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "group" is deleted
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin resets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin removes a "cognito" "user" from a "cognito" "group" then an admin sets a "cognito" "user" password
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a confirmed enabled user initiates authentication then a "cognito" "user" was "DISABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" responds to an auth challenge then a "cognito" "user" was "ENABLED" by an admin
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an admin initiates authentication on behalf of a confirmed enabled user then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then an authenticated session expires then a "cognito" "user" is marked as compromised
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an authenticated session expires
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is created in an active "cognito" "user pool" then a verification code delivery fails for an unconfirmed user then a "cognito" "group" is deleted
    Given pool_id in pool_status
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user pool" is created then an admin removes a "cognito" "user" from a "cognito" "group"
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user pool" is created
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user pool" is deleted then a confirmed enabled user initiates authentication
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user pool" is deleted
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" responds to an auth challenge
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" is deleted by an admin then an admin initiates authentication on behalf of a confirmed enabled user
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" is deleted by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin confirms a "cognito" "user" registration then an authenticated session expires
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin confirms a "cognito" "user" registration
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin resets a "cognito" "user" password then a verification code delivery fails for an unconfirmed user
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin resets a "cognito" "user" password
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin sets a "cognito" "user" password then a "cognito" "user pool" is created
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin sets a "cognito" "user" password
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user pool" is deleted
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin updates attributes for a confirmed user then a "cognito" "user" is deleted by an admin
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" is marked as compromised then an admin confirms a "cognito" "user" registration
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" is marked as compromised
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "group" is created in an active "cognito" "user pool" then an admin resets a "cognito" "user" password
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin sets a "cognito" "user" password
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" was "DISABLED" by an admin
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a confirmed enabled user initiates authentication then a "cognito" "user" was "ENABLED" by an admin
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a "cognito" "user" responds to an auth challenge then an admin updates attributes for a confirmed user
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a "cognito" "user" responds to an auth challenge
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" is marked as compromised
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then an authenticated session expires then a "cognito" "group" is created in an active "cognito" "user pool"
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When an authenticated session expires
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "group" is deleted then a verification code delivery fails for an unconfirmed user then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given group_id in group_status
    When a "cognito" "group" is deleted
    When a verification code delivery fails for an unconfirmed user
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user pool" is created then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user pool" is created
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user pool" is deleted then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" is deleted by an admin then an authenticated session expires
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" is deleted by an admin
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin confirms a "cognito" "user" registration then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin confirms a "cognito" "user" registration
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin resets a "cognito" "user" password then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin resets a "cognito" "user" password
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin sets a "cognito" "user" password then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin sets a "cognito" "user" password
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin updates attributes for a confirmed user then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin updates attributes for a confirmed user
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" is marked as compromised then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" is marked as compromised
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "group" is created in an active "cognito" "user pool" then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "group" is deleted then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "group" is deleted
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a confirmed enabled user initiates authentication then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a confirmed enabled user initiates authentication
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" responds to an auth challenge then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an authenticated session expires then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an authenticated session expires
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a verification code delivery fails for an unconfirmed user then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a verification code delivery fails for an unconfirmed user
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user pool" is created then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user pool" is created
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user pool" is deleted then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user pool" is deleted
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an authenticated session expires
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" is deleted by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" is deleted by an admin
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin confirms a "cognito" "user" registration then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin resets a "cognito" "user" password then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin resets a "cognito" "user" password
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin sets a "cognito" "user" password then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" was "ENABLED" by an admin then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin updates attributes for a confirmed user then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin updates attributes for a confirmed user
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" is marked as compromised then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" is marked as compromised
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "group" is deleted then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "group" is deleted
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a confirmed enabled user initiates authentication then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" responds to an auth challenge then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then an authenticated session expires then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an authenticated session expires
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin removes a "cognito" "user" from a "cognito" "group" then a verification code delivery fails for an unconfirmed user then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a verification code delivery fails for an unconfirmed user
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user pool" is created then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user pool" is created
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user pool" is deleted then an authenticated session expires
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user pool" is deleted
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" is deleted by an admin then a "cognito" "user pool" is created
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin confirms a "cognito" "user" registration then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin resets a "cognito" "user" password then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin sets a "cognito" "user" password then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" was "DISABLED" by an admin then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" was "ENABLED" by an admin then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin updates attributes for a confirmed user then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin updates attributes for a confirmed user
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" is marked as compromised then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "group" is deleted then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "group" is deleted
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a "cognito" "user" responds to an auth challenge then a "cognito" "group" is deleted
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin initiates authentication on behalf of a confirmed enabled user then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then an authenticated session expires then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When an authenticated session expires
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a confirmed enabled user initiates authentication then a verification code delivery fails for an unconfirmed user then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When a confirmed enabled user initiates authentication
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user pool" is created then an authenticated session expires
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user pool" is created
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user pool" is deleted then a verification code delivery fails for an unconfirmed user
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user pool" is deleted
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user pool" is created
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user" is deleted by an admin then a "cognito" "user pool" is deleted
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin confirms a "cognito" "user" registration then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin resets a "cognito" "user" password then a "cognito" "user" is deleted by an admin
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin sets a "cognito" "user" password then an admin confirms a "cognito" "user" registration
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin sets a "cognito" "user" password
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user" was "DISABLED" by an admin then an admin resets a "cognito" "user" password
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user" was "ENABLED" by an admin then an admin sets a "cognito" "user" password
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin updates attributes for a confirmed user then a "cognito" "user" was "DISABLED" by an admin
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "user" is marked as compromised then a "cognito" "user" was "ENABLED" by an admin
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "user" is marked as compromised
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "group" is created in an active "cognito" "user pool" then an admin updates attributes for a confirmed user
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a "cognito" "group" is deleted then a "cognito" "user" is marked as compromised
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a "cognito" "group" is deleted
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "group" is created in an active "cognito" "user pool"
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "group" is deleted
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a confirmed enabled user initiates authentication then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a confirmed enabled user initiates authentication
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an admin initiates authentication on behalf of a confirmed enabled user then an admin removes a "cognito" "user" from a "cognito" "group"
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then an authenticated session expires then a confirmed enabled user initiates authentication
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When an authenticated session expires
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a "cognito" "user" responds to an auth challenge then a verification code delivery fails for an unconfirmed user then an admin initiates authentication on behalf of a confirmed enabled user
    Given session_id in session_status
    When a "cognito" "user" responds to an auth challenge
    When a verification code delivery fails for an unconfirmed user
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user pool" is created then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user pool" is created
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user pool" is deleted then a "cognito" "user pool" is created
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user pool" is deleted
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" is deleted by an admin then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" is deleted by an admin
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin confirms a "cognito" "user" registration then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin confirms a "cognito" "user" registration
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin resets a "cognito" "user" password then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin resets a "cognito" "user" password
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin sets a "cognito" "user" password then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin sets a "cognito" "user" password
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" was "DISABLED" by an admin then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin updates attributes for a confirmed user then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" is marked as compromised then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" is marked as compromised
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "group" is deleted then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "group" is deleted
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a "cognito" "group" is deleted
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin removes a "cognito" "user" from a "cognito" "group" then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a confirmed enabled user initiates authentication then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a confirmed enabled user initiates authentication
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user" responds to an auth challenge then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user" responds to an auth challenge
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an authenticated session expires then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When an authenticated session expires
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a verification code delivery fails for an unconfirmed user then an authenticated session expires
    Given user_id in user_status
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a verification code delivery fails for an unconfirmed user
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user pool" is created then a "cognito" "user pool" is deleted
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user pool" is created
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user pool" is deleted then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then a "cognito" "user" is deleted by an admin
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" is deleted by an admin then an admin confirms a "cognito" "user" registration
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" is deleted by an admin
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin confirms a "cognito" "user" registration then an admin resets a "cognito" "user" password
    Given session_id in session_status
    When an authenticated session expires
    When an admin confirms a "cognito" "user" registration
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin resets a "cognito" "user" password then an admin sets a "cognito" "user" password
    Given session_id in session_status
    When an authenticated session expires
    When an admin resets a "cognito" "user" password
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin sets a "cognito" "user" password then a "cognito" "user" was "DISABLED" by an admin
    Given session_id in session_status
    When an authenticated session expires
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" was "DISABLED" by an admin then a "cognito" "user" was "ENABLED" by an admin
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" was "DISABLED" by an admin
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" was "ENABLED" by an admin then an admin updates attributes for a confirmed user
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" was "ENABLED" by an admin
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin updates attributes for a confirmed user then a "cognito" "user" is marked as compromised
    Given session_id in session_status
    When an authenticated session expires
    When an admin updates attributes for a confirmed user
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" is marked as compromised then a "cognito" "group" is created in an active "cognito" "user pool"
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" is marked as compromised
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "group" is created in an active "cognito" "user pool" then a "cognito" "group" is deleted
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "group" is deleted then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "group" is deleted
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then an admin removes a "cognito" "user" from a "cognito" "group"
    Given session_id in session_status
    When an authenticated session expires
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin removes a "cognito" "user" from a "cognito" "group" then a confirmed enabled user initiates authentication
    Given session_id in session_status
    When an authenticated session expires
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a confirmed enabled user initiates authentication then a "cognito" "user" responds to an auth challenge
    Given session_id in session_status
    When an authenticated session expires
    When a confirmed enabled user initiates authentication
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a "cognito" "user" responds to an auth challenge then an admin initiates authentication on behalf of a confirmed enabled user
    Given session_id in session_status
    When an authenticated session expires
    When a "cognito" "user" responds to an auth challenge
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then an admin initiates authentication on behalf of a confirmed enabled user then a verification code delivery fails for an unconfirmed user
    Given session_id in session_status
    When an authenticated session expires
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a verification code delivery fails for an unconfirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: an authenticated session expires then a verification code delivery fails for an unconfirmed user then a "cognito" "user pool" is created
    Given session_id in session_status
    When an authenticated session expires
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user pool" is created then a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user pool" is created
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user pool" is deleted then a "cognito" "user" is deleted by an admin
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user pool" is deleted
    When a "cognito" "user" is deleted by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" is created by an admin in an active "cognito" "user pool" then an admin confirms a "cognito" "user" registration
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" is created by an admin in an active "cognito" "user pool"
    When an admin confirms a "cognito" "user" registration
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" is deleted by an admin then an admin resets a "cognito" "user" password
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" is deleted by an admin
    When an admin resets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin confirms a "cognito" "user" registration then an admin sets a "cognito" "user" password
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin confirms a "cognito" "user" registration
    When an admin sets a "cognito" "user" password
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin resets a "cognito" "user" password then a "cognito" "user" was "DISABLED" by an admin
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin resets a "cognito" "user" password
    When a "cognito" "user" was "DISABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin sets a "cognito" "user" password then a "cognito" "user" was "ENABLED" by an admin
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin sets a "cognito" "user" password
    When a "cognito" "user" was "ENABLED" by an admin
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" was "DISABLED" by an admin then an admin updates attributes for a confirmed user
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" was "DISABLED" by an admin
    When an admin updates attributes for a confirmed user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" was "ENABLED" by an admin then a "cognito" "user" is marked as compromised
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" was "ENABLED" by an admin
    When a "cognito" "user" is marked as compromised
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin updates attributes for a confirmed user then a "cognito" "group" is created in an active "cognito" "user pool"
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin updates attributes for a confirmed user
    When a "cognito" "group" is created in an active "cognito" "user pool"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" is marked as compromised then a "cognito" "group" is deleted
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" is marked as compromised
    When a "cognito" "group" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "group" is created in an active "cognito" "user pool" then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "group" is created in an active "cognito" "user pool"
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "group" is deleted then an admin removes a "cognito" "user" from a "cognito" "group"
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "group" is deleted
    When an admin removes a "cognito" "user" from a "cognito" "group"
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin adds a "cognito" "user" to a "cognito" "group" in the same pool then a confirmed enabled user initiates authentication
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin adds a "cognito" "user" to a "cognito" "group" in the same pool
    When a confirmed enabled user initiates authentication
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin removes a "cognito" "user" from a "cognito" "group" then a "cognito" "user" responds to an auth challenge
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin removes a "cognito" "user" from a "cognito" "group"
    When a "cognito" "user" responds to an auth challenge
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a confirmed enabled user initiates authentication then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a confirmed enabled user initiates authentication
    When an admin initiates authentication on behalf of a confirmed enabled user
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a "cognito" "user" responds to an auth challenge then an authenticated session expires
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When a "cognito" "user" responds to an auth challenge
    When an authenticated session expires
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin initiates authentication on behalf of a confirmed enabled user then a "cognito" "user pool" is created
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an admin initiates authentication on behalf of a confirmed enabled user
    When a "cognito" "user pool" is created
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an authenticated session expires then a "cognito" "user pool" is deleted
    Given user_id in user_status
    When a verification code delivery fails for an unconfirmed user
    When an authenticated session expires
    When a "cognito" "user pool" is deleted
    And every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions
