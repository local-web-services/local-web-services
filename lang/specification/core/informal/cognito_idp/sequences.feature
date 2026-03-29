@cognitoidp @generated
Feature: CognitoIdp - Action Sequences

  # Generated from FizzBee spec: cognito_idp.fizz
  # Safety invariants: ValidUserPoolStatus, ValidUserStatus, UserGroupMembershipEntryExists, GroupMembershipReferencesExistingGroups, ValidAuthSessionStatus, DeletedUsersNotAuthenticated, DisabledUsersNotAuthenticated

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a user pool is created then a user pool is deleted
    Given pool_id not in pool_status
    Given a user pool has been created
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user is created by an admin in an active user pool
    Given pool_id not in pool_status
    Given a user pool has been created
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user is deleted by an admin
    Given pool_id not in pool_status
    Given a user pool has been created
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin confirms a user registration
    Given pool_id not in pool_status
    Given a user pool has been created
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin resets a user password
    Given pool_id not in pool_status
    Given a user pool has been created
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin sets a user password
    Given pool_id not in pool_status
    Given a user pool has been created
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user account is disabled by an admin
    Given pool_id not in pool_status
    Given a user pool has been created
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user account is enabled by an admin
    Given pool_id not in pool_status
    Given a user pool has been created
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin updates attributes for a confirmed user
    Given pool_id not in pool_status
    Given a user pool has been created
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user account is marked as compromised
    Given pool_id not in pool_status
    Given a user pool has been created
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a group is created in an active user pool
    Given pool_id not in pool_status
    Given a user pool has been created
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a group is deleted
    Given pool_id not in pool_status
    Given a user pool has been created
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin adds a user to a group in the same pool
    Given pool_id not in pool_status
    Given a user pool has been created
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin removes a user from a group
    Given pool_id not in pool_status
    Given a user pool has been created
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a confirmed enabled user initiates authentication
    Given pool_id not in pool_status
    Given a user pool has been created
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user responds to an auth challenge
    Given pool_id not in pool_status
    Given a user pool has been created
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id not in pool_status
    Given a user pool has been created
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an authenticated session expires
    Given pool_id not in pool_status
    Given a user pool has been created
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a verification code delivery fails for an unconfirmed user
    Given pool_id not in pool_status
    Given a user pool has been created
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user pool is created
    Given pool_id in pool_status
    Given a user pool has been deleted
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user is created by an admin in an active user pool
    Given pool_id in pool_status
    Given a user pool has been deleted
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user is deleted by an admin
    Given pool_id in pool_status
    Given a user pool has been deleted
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin confirms a user registration
    Given pool_id in pool_status
    Given a user pool has been deleted
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin resets a user password
    Given pool_id in pool_status
    Given a user pool has been deleted
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin sets a user password
    Given pool_id in pool_status
    Given a user pool has been deleted
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user account is disabled by an admin
    Given pool_id in pool_status
    Given a user pool has been deleted
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user account is enabled by an admin
    Given pool_id in pool_status
    Given a user pool has been deleted
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    Given a user pool has been deleted
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user account is marked as compromised
    Given pool_id in pool_status
    Given a user pool has been deleted
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a group is created in an active user pool
    Given pool_id in pool_status
    Given a user pool has been deleted
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a group is deleted
    Given pool_id in pool_status
    Given a user pool has been deleted
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin adds a user to a group in the same pool
    Given pool_id in pool_status
    Given a user pool has been deleted
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin removes a user from a group
    Given pool_id in pool_status
    Given a user pool has been deleted
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    Given a user pool has been deleted
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user responds to an auth challenge
    Given pool_id in pool_status
    Given a user pool has been deleted
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    Given a user pool has been deleted
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an authenticated session expires
    Given pool_id in pool_status
    Given a user pool has been deleted
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    Given a user pool has been deleted
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user pool is created
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user pool is deleted
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user is deleted by an admin
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin confirms a user registration
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin resets a user password
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin sets a user password
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user account is disabled by an admin
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user account is enabled by an admin
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user account is marked as compromised
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a group is created in an active user pool
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a group is deleted
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin adds a user to a group in the same pool
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin removes a user from a group
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user responds to an auth challenge
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an authenticated session expires
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user pool is created
    Given user_id in user_status
    Given a user has been deleted by an admin
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user pool is deleted
    Given user_id in user_status
    Given a user has been deleted by an admin
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given a user has been deleted by an admin
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin confirms a user registration
    Given user_id in user_status
    Given a user has been deleted by an admin
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin resets a user password
    Given user_id in user_status
    Given a user has been deleted by an admin
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin sets a user password
    Given user_id in user_status
    Given a user has been deleted by an admin
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user account is disabled by an admin
    Given user_id in user_status
    Given a user has been deleted by an admin
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user account is enabled by an admin
    Given user_id in user_status
    Given a user has been deleted by an admin
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given a user has been deleted by an admin
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user account is marked as compromised
    Given user_id in user_status
    Given a user has been deleted by an admin
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a group is created in an active user pool
    Given user_id in user_status
    Given a user has been deleted by an admin
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a group is deleted
    Given user_id in user_status
    Given a user has been deleted by an admin
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given a user has been deleted by an admin
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin removes a user from a group
    Given user_id in user_status
    Given a user has been deleted by an admin
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given a user has been deleted by an admin
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user responds to an auth challenge
    Given user_id in user_status
    Given a user has been deleted by an admin
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given a user has been deleted by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an authenticated session expires
    Given user_id in user_status
    Given a user has been deleted by an admin
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given a user has been deleted by an admin
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user pool is created
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user pool is deleted
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin resets a user password
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin sets a user password
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a group is deleted
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an authenticated session expires
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has confirmed a user registration
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user pool is created
    Given user_id in user_status
    Given an admin has reset a user password
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user pool is deleted
    Given user_id in user_status
    Given an admin has reset a user password
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has reset a user password
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has reset a user password
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has reset a user password
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin sets a user password
    Given user_id in user_status
    Given an admin has reset a user password
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has reset a user password
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has reset a user password
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has reset a user password
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has reset a user password
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has reset a user password
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a group is deleted
    Given user_id in user_status
    Given an admin has reset a user password
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has reset a user password
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has reset a user password
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has reset a user password
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has reset a user password
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has reset a user password
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an authenticated session expires
    Given user_id in user_status
    Given an admin has reset a user password
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has reset a user password
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user pool is created
    Given user_id in user_status
    Given an admin has set a user password
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user pool is deleted
    Given user_id in user_status
    Given an admin has set a user password
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has set a user password
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has set a user password
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has set a user password
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin resets a user password
    Given user_id in user_status
    Given an admin has set a user password
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has set a user password
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has set a user password
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has set a user password
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has set a user password
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has set a user password
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a group is deleted
    Given user_id in user_status
    Given an admin has set a user password
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has set a user password
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has set a user password
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has set a user password
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has set a user password
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has set a user password
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an authenticated session expires
    Given user_id in user_status
    Given an admin has set a user password
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has set a user password
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user pool is created
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user pool is deleted
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user is created by an admin in an active user pool
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user is deleted by an admin
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin confirms a user registration
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin resets a user password
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin sets a user password
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user account is enabled by an admin
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin updates attributes for a confirmed user
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user account is marked as compromised
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a group is created in an active user pool
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a group is deleted
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin adds a user to a group in the same pool
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin removes a user from a group
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a confirmed enabled user initiates authentication
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user responds to an auth challenge
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an authenticated session expires
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user pool is created
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user pool is deleted
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user is created by an admin in an active user pool
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user is deleted by an admin
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin confirms a user registration
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin resets a user password
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin sets a user password
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user account is disabled by an admin
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin updates attributes for a confirmed user
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user account is marked as compromised
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a group is created in an active user pool
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a group is deleted
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin adds a user to a group in the same pool
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin removes a user from a group
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a confirmed enabled user initiates authentication
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user responds to an auth challenge
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an authenticated session expires
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user pool is created
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user pool is deleted
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin resets a user password
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin sets a user password
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a group is deleted
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an authenticated session expires
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user pool is created
    Given user_id in user_status
    Given a user account has been marked as compromised
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user pool is deleted
    Given user_id in user_status
    Given a user account has been marked as compromised
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given a user account has been marked as compromised
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user is deleted by an admin
    Given user_id in user_status
    Given a user account has been marked as compromised
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin confirms a user registration
    Given user_id in user_status
    Given a user account has been marked as compromised
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin resets a user password
    Given user_id in user_status
    Given a user account has been marked as compromised
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin sets a user password
    Given user_id in user_status
    Given a user account has been marked as compromised
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user account is disabled by an admin
    Given user_id in user_status
    Given a user account has been marked as compromised
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user account is enabled by an admin
    Given user_id in user_status
    Given a user account has been marked as compromised
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given a user account has been marked as compromised
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a group is created in an active user pool
    Given user_id in user_status
    Given a user account has been marked as compromised
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a group is deleted
    Given user_id in user_status
    Given a user account has been marked as compromised
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given a user account has been marked as compromised
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin removes a user from a group
    Given user_id in user_status
    Given a user account has been marked as compromised
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given a user account has been marked as compromised
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user responds to an auth challenge
    Given user_id in user_status
    Given a user account has been marked as compromised
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given a user account has been marked as compromised
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an authenticated session expires
    Given user_id in user_status
    Given a user account has been marked as compromised
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given a user account has been marked as compromised
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user pool is created
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user pool is deleted
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user is created by an admin in an active user pool
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user is deleted by an admin
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin confirms a user registration
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin resets a user password
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin sets a user password
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user account is disabled by an admin
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user account is enabled by an admin
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user account is marked as compromised
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a group is deleted
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin adds a user to a group in the same pool
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin removes a user from a group
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user responds to an auth challenge
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an authenticated session expires
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user pool is created
    Given group_id in group_status
    Given a group has been deleted
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user pool is deleted
    Given group_id in group_status
    Given a group has been deleted
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user is created by an admin in an active user pool
    Given group_id in group_status
    Given a group has been deleted
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user is deleted by an admin
    Given group_id in group_status
    Given a group has been deleted
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin confirms a user registration
    Given group_id in group_status
    Given a group has been deleted
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin resets a user password
    Given group_id in group_status
    Given a group has been deleted
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin sets a user password
    Given group_id in group_status
    Given a group has been deleted
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user account is disabled by an admin
    Given group_id in group_status
    Given a group has been deleted
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user account is enabled by an admin
    Given group_id in group_status
    Given a group has been deleted
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin updates attributes for a confirmed user
    Given group_id in group_status
    Given a group has been deleted
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user account is marked as compromised
    Given group_id in group_status
    Given a group has been deleted
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a group is created in an active user pool
    Given group_id in group_status
    Given a group has been deleted
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin adds a user to a group in the same pool
    Given group_id in group_status
    Given a group has been deleted
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin removes a user from a group
    Given group_id in group_status
    Given a group has been deleted
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a confirmed enabled user initiates authentication
    Given group_id in group_status
    Given a group has been deleted
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user responds to an auth challenge
    Given group_id in group_status
    Given a group has been deleted
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin initiates authentication on behalf of a confirmed enabled user
    Given group_id in group_status
    Given a group has been deleted
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an authenticated session expires
    Given group_id in group_status
    Given a group has been deleted
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a verification code delivery fails for an unconfirmed user
    Given group_id in group_status
    Given a group has been deleted
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user pool is created
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user pool is deleted
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin resets a user password
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin sets a user password
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a group is deleted
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an authenticated session expires
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user pool is created
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user pool is deleted
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has removed a user from a group
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin resets a user password
    Given user_id in user_status
    Given an admin has removed a user from a group
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin sets a user password
    Given user_id in user_status
    Given an admin has removed a user from a group
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has removed a user from a group
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a group is deleted
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has removed a user from a group
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has removed a user from a group
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an authenticated session expires
    Given user_id in user_status
    Given an admin has removed a user from a group
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has removed a user from a group
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user pool is created
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user pool is deleted
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user is deleted by an admin
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin confirms a user registration
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin resets a user password
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin sets a user password
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user account is disabled by an admin
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user account is enabled by an admin
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user account is marked as compromised
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a group is created in an active user pool
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a group is deleted
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin removes a user from a group
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user responds to an auth challenge
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an authenticated session expires
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user pool is created
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user pool is deleted
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user is created by an admin in an active user pool
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user is deleted by an admin
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin confirms a user registration
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin resets a user password
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin sets a user password
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user account is disabled by an admin
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user account is enabled by an admin
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin updates attributes for a confirmed user
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user account is marked as compromised
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a group is created in an active user pool
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a group is deleted
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin adds a user to a group in the same pool
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin removes a user from a group
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a confirmed enabled user initiates authentication
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin initiates authentication on behalf of a confirmed enabled user
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an authenticated session expires
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a verification code delivery fails for an unconfirmed user
    Given session_id in session_status
    Given a user has responded to an auth challenge
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user pool is created
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user pool is deleted
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin resets a user password
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin sets a user password
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a group is deleted
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an authenticated session expires
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user pool is created
    Given session_id in session_status
    Given an authenticated session has expired
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user pool is deleted
    Given session_id in session_status
    Given an authenticated session has expired
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user is created by an admin in an active user pool
    Given session_id in session_status
    Given an authenticated session has expired
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user is deleted by an admin
    Given session_id in session_status
    Given an authenticated session has expired
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin confirms a user registration
    Given session_id in session_status
    Given an authenticated session has expired
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin resets a user password
    Given session_id in session_status
    Given an authenticated session has expired
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin sets a user password
    Given session_id in session_status
    Given an authenticated session has expired
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user account is disabled by an admin
    Given session_id in session_status
    Given an authenticated session has expired
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user account is enabled by an admin
    Given session_id in session_status
    Given an authenticated session has expired
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin updates attributes for a confirmed user
    Given session_id in session_status
    Given an authenticated session has expired
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user account is marked as compromised
    Given session_id in session_status
    Given an authenticated session has expired
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a group is created in an active user pool
    Given session_id in session_status
    Given an authenticated session has expired
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a group is deleted
    Given session_id in session_status
    Given an authenticated session has expired
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin adds a user to a group in the same pool
    Given session_id in session_status
    Given an authenticated session has expired
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin removes a user from a group
    Given session_id in session_status
    Given an authenticated session has expired
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a confirmed enabled user initiates authentication
    Given session_id in session_status
    Given an authenticated session has expired
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user responds to an auth challenge
    Given session_id in session_status
    Given an authenticated session has expired
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin initiates authentication on behalf of a confirmed enabled user
    Given session_id in session_status
    Given an authenticated session has expired
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a verification code delivery fails for an unconfirmed user
    Given session_id in session_status
    Given an authenticated session has expired
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user pool is created
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user pool is deleted
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user is deleted by an admin
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin confirms a user registration
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin resets a user password
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin sets a user password
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user account is disabled by an admin
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user account is enabled by an admin
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user account is marked as compromised
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a group is created in an active user pool
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a group is deleted
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin removes a user from a group
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user responds to an auth challenge
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an authenticated session expires
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user pool is deleted then a user is created by an admin in an active user pool
    Given pool_id not in pool_status
    Given a user pool has been created
    Given a user pool has been deleted
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user is created by an admin in an active user pool then a user is deleted by an admin
    Given pool_id not in pool_status
    Given a user pool has been created
    Given a user has been created by an admin in an active user pool
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user is deleted by an admin then an admin confirms a user registration
    Given pool_id not in pool_status
    Given a user pool has been created
    Given a user has been deleted by an admin
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin confirms a user registration then an admin resets a user password
    Given pool_id not in pool_status
    Given a user pool has been created
    Given an admin has confirmed a user registration
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin resets a user password then an admin sets a user password
    Given pool_id not in pool_status
    Given a user pool has been created
    Given an admin has reset a user password
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin sets a user password then a user account is disabled by an admin
    Given pool_id not in pool_status
    Given a user pool has been created
    Given an admin has set a user password
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user account is disabled by an admin then a user account is enabled by an admin
    Given pool_id not in pool_status
    Given a user pool has been created
    Given a user account has been disabled by an admin
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user account is enabled by an admin then an admin updates attributes for a confirmed user
    Given pool_id not in pool_status
    Given a user pool has been created
    Given a user account has been enabled by an admin
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin updates attributes for a confirmed user then a user account is marked as compromised
    Given pool_id not in pool_status
    Given a user pool has been created
    Given an admin has updated attributes for a confirmed user
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user account is marked as compromised then a group is created in an active user pool
    Given pool_id not in pool_status
    Given a user pool has been created
    Given a user account has been marked as compromised
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a group is created in an active user pool then a group is deleted
    Given pool_id not in pool_status
    Given a user pool has been created
    Given a group has been created in an active user pool
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a group is deleted then an admin adds a user to a group in the same pool
    Given pool_id not in pool_status
    Given a user pool has been created
    Given a group has been deleted
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin adds a user to a group in the same pool then an admin removes a user from a group
    Given pool_id not in pool_status
    Given a user pool has been created
    Given an admin has added a user to a group in the same pool
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin removes a user from a group then a confirmed enabled user initiates authentication
    Given pool_id not in pool_status
    Given a user pool has been created
    Given an admin has removed a user from a group
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a confirmed enabled user initiates authentication then a user responds to an auth challenge
    Given pool_id not in pool_status
    Given a user pool has been created
    Given a confirmed enabled user has initiated authentication
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a user responds to an auth challenge then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id not in pool_status
    Given a user pool has been created
    Given a user has responded to an auth challenge
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an admin initiates authentication on behalf of a confirmed enabled user then an authenticated session expires
    Given pool_id not in pool_status
    Given a user pool has been created
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then an authenticated session expires then a verification code delivery fails for an unconfirmed user
    Given pool_id not in pool_status
    Given a user pool has been created
    Given an authenticated session has expired
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is created then a verification code delivery fails for an unconfirmed user then a user pool is deleted
    Given pool_id not in pool_status
    Given a user pool has been created
    Given a verification code delivery has failed for an unconfirmed user
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user pool is created then a user is deleted by an admin
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given a user pool has been created
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user is created by an admin in an active user pool then an admin confirms a user registration
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given a user has been created by an admin in an active user pool
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user is deleted by an admin then an admin resets a user password
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given a user has been deleted by an admin
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin confirms a user registration then an admin sets a user password
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given an admin has confirmed a user registration
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin resets a user password then a user account is disabled by an admin
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given an admin has reset a user password
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin sets a user password then a user account is enabled by an admin
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given an admin has set a user password
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user account is disabled by an admin then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given a user account has been disabled by an admin
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user account is enabled by an admin then a user account is marked as compromised
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given a user account has been enabled by an admin
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin updates attributes for a confirmed user then a group is created in an active user pool
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given an admin has updated attributes for a confirmed user
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user account is marked as compromised then a group is deleted
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given a user account has been marked as compromised
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a group is created in an active user pool then an admin adds a user to a group in the same pool
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given a group has been created in an active user pool
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a group is deleted then an admin removes a user from a group
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given a group has been deleted
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin adds a user to a group in the same pool then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given an admin has added a user to a group in the same pool
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin removes a user from a group then a user responds to an auth challenge
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given an admin has removed a user from a group
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a confirmed enabled user initiates authentication then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given a confirmed enabled user has initiated authentication
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a user responds to an auth challenge then an authenticated session expires
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given a user has responded to an auth challenge
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an admin initiates authentication on behalf of a confirmed enabled user then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then an authenticated session expires then a user pool is created
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given an authenticated session has expired
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user pool is deleted then a verification code delivery fails for an unconfirmed user then a user is created by an admin in an active user pool
    Given pool_id in pool_status
    Given a user pool has been deleted
    Given a verification code delivery has failed for an unconfirmed user
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user pool is created then an admin confirms a user registration
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given a user pool has been created
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user pool is deleted then an admin resets a user password
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given a user pool has been deleted
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user is deleted by an admin then an admin sets a user password
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given a user has been deleted by an admin
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin confirms a user registration then a user account is disabled by an admin
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given an admin has confirmed a user registration
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin resets a user password then a user account is enabled by an admin
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given an admin has reset a user password
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin sets a user password then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given an admin has set a user password
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user account is disabled by an admin then a user account is marked as compromised
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given a user account has been disabled by an admin
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user account is enabled by an admin then a group is created in an active user pool
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given a user account has been enabled by an admin
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin updates attributes for a confirmed user then a group is deleted
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given an admin has updated attributes for a confirmed user
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user account is marked as compromised then an admin adds a user to a group in the same pool
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given a user account has been marked as compromised
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a group is created in an active user pool then an admin removes a user from a group
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given a group has been created in an active user pool
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a group is deleted then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given a group has been deleted
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin adds a user to a group in the same pool then a user responds to an auth challenge
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given an admin has added a user to a group in the same pool
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin removes a user from a group then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given an admin has removed a user from a group
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a confirmed enabled user initiates authentication then an authenticated session expires
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given a confirmed enabled user has initiated authentication
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a user responds to an auth challenge then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given a user has responded to an auth challenge
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an admin initiates authentication on behalf of a confirmed enabled user then a user pool is created
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then an authenticated session expires then a user pool is deleted
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given an authenticated session has expired
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is created by an admin in an active user pool then a verification code delivery fails for an unconfirmed user then a user is deleted by an admin
    Given pool_id in pool_status
    Given a user has been created by an admin in an active user pool
    Given a verification code delivery has failed for an unconfirmed user
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user pool is created then an admin resets a user password
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given a user pool has been created
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user pool is deleted then an admin sets a user password
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given a user pool has been deleted
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user is created by an admin in an active user pool then a user account is disabled by an admin
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given a user has been created by an admin in an active user pool
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin confirms a user registration then a user account is enabled by an admin
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given an admin has confirmed a user registration
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin resets a user password then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given an admin has reset a user password
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin sets a user password then a user account is marked as compromised
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given an admin has set a user password
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user account is disabled by an admin then a group is created in an active user pool
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given a user account has been disabled by an admin
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user account is enabled by an admin then a group is deleted
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given a user account has been enabled by an admin
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin updates attributes for a confirmed user then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given an admin has updated attributes for a confirmed user
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user account is marked as compromised then an admin removes a user from a group
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given a user account has been marked as compromised
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a group is created in an active user pool then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given a group has been created in an active user pool
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a group is deleted then a user responds to an auth challenge
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given a group has been deleted
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin adds a user to a group in the same pool then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given an admin has added a user to a group in the same pool
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin removes a user from a group then an authenticated session expires
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given an admin has removed a user from a group
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a confirmed enabled user initiates authentication then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given a confirmed enabled user has initiated authentication
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a user responds to an auth challenge then a user pool is created
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given a user has responded to an auth challenge
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an admin initiates authentication on behalf of a confirmed enabled user then a user pool is deleted
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then an authenticated session expires then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given an authenticated session has expired
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user is deleted by an admin then a verification code delivery fails for an unconfirmed user then an admin confirms a user registration
    Given user_id in user_status
    Given a user has been deleted by an admin
    Given a verification code delivery has failed for an unconfirmed user
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user pool is created then an admin sets a user password
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a user pool has been created
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user pool is deleted then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a user pool has been deleted
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user is created by an admin in an active user pool then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a user has been created by an admin in an active user pool
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user is deleted by an admin then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a user has been deleted by an admin
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin resets a user password then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given an admin has reset a user password
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin sets a user password then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given an admin has set a user password
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user account is disabled by an admin then a group is deleted
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a user account has been disabled by an admin
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user account is enabled by an admin then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a user account has been enabled by an admin
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin updates attributes for a confirmed user then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given an admin has updated attributes for a confirmed user
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user account is marked as compromised then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a user account has been marked as compromised
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a group is created in an active user pool then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a group has been created in an active user pool
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a group is deleted then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a group has been deleted
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin adds a user to a group in the same pool then an authenticated session expires
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given an admin has added a user to a group in the same pool
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin removes a user from a group then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given an admin has removed a user from a group
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a confirmed enabled user initiates authentication then a user pool is created
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a confirmed enabled user has initiated authentication
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a user responds to an auth challenge then a user pool is deleted
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a user has responded to an auth challenge
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an admin initiates authentication on behalf of a confirmed enabled user then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then an authenticated session expires then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given an authenticated session has expired
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin confirms a user registration then a verification code delivery fails for an unconfirmed user then an admin resets a user password
    Given user_id in user_status
    Given an admin has confirmed a user registration
    Given a verification code delivery has failed for an unconfirmed user
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user pool is created then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has reset a user password
    Given a user pool has been created
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user pool is deleted then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has reset a user password
    Given a user pool has been deleted
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user is created by an admin in an active user pool then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has reset a user password
    Given a user has been created by an admin in an active user pool
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user is deleted by an admin then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has reset a user password
    Given a user has been deleted by an admin
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin confirms a user registration then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has reset a user password
    Given an admin has confirmed a user registration
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin sets a user password then a group is deleted
    Given user_id in user_status
    Given an admin has reset a user password
    Given an admin has set a user password
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user account is disabled by an admin then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has reset a user password
    Given a user account has been disabled by an admin
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user account is enabled by an admin then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has reset a user password
    Given a user account has been enabled by an admin
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin updates attributes for a confirmed user then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has reset a user password
    Given an admin has updated attributes for a confirmed user
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user account is marked as compromised then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has reset a user password
    Given a user account has been marked as compromised
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a group is created in an active user pool then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has reset a user password
    Given a group has been created in an active user pool
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a group is deleted then an authenticated session expires
    Given user_id in user_status
    Given an admin has reset a user password
    Given a group has been deleted
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin adds a user to a group in the same pool then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has reset a user password
    Given an admin has added a user to a group in the same pool
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin removes a user from a group then a user pool is created
    Given user_id in user_status
    Given an admin has reset a user password
    Given an admin has removed a user from a group
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a confirmed enabled user initiates authentication then a user pool is deleted
    Given user_id in user_status
    Given an admin has reset a user password
    Given a confirmed enabled user has initiated authentication
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a user responds to an auth challenge then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has reset a user password
    Given a user has responded to an auth challenge
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an admin initiates authentication on behalf of a confirmed enabled user then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has reset a user password
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then an authenticated session expires then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has reset a user password
    Given an authenticated session has expired
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin resets a user password then a verification code delivery fails for an unconfirmed user then an admin sets a user password
    Given user_id in user_status
    Given an admin has reset a user password
    Given a verification code delivery has failed for an unconfirmed user
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user pool is created then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has set a user password
    Given a user pool has been created
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user pool is deleted then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has set a user password
    Given a user pool has been deleted
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user is created by an admin in an active user pool then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has set a user password
    Given a user has been created by an admin in an active user pool
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user is deleted by an admin then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has set a user password
    Given a user has been deleted by an admin
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin confirms a user registration then a group is deleted
    Given user_id in user_status
    Given an admin has set a user password
    Given an admin has confirmed a user registration
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin resets a user password then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has set a user password
    Given an admin has reset a user password
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user account is disabled by an admin then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has set a user password
    Given a user account has been disabled by an admin
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user account is enabled by an admin then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has set a user password
    Given a user account has been enabled by an admin
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin updates attributes for a confirmed user then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has set a user password
    Given an admin has updated attributes for a confirmed user
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user account is marked as compromised then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has set a user password
    Given a user account has been marked as compromised
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a group is created in an active user pool then an authenticated session expires
    Given user_id in user_status
    Given an admin has set a user password
    Given a group has been created in an active user pool
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a group is deleted then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has set a user password
    Given a group has been deleted
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin adds a user to a group in the same pool then a user pool is created
    Given user_id in user_status
    Given an admin has set a user password
    Given an admin has added a user to a group in the same pool
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin removes a user from a group then a user pool is deleted
    Given user_id in user_status
    Given an admin has set a user password
    Given an admin has removed a user from a group
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a confirmed enabled user initiates authentication then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has set a user password
    Given a confirmed enabled user has initiated authentication
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a user responds to an auth challenge then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has set a user password
    Given a user has responded to an auth challenge
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an admin initiates authentication on behalf of a confirmed enabled user then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has set a user password
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then an authenticated session expires then an admin resets a user password
    Given user_id in user_status
    Given an admin has set a user password
    Given an authenticated session has expired
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin sets a user password then a verification code delivery fails for an unconfirmed user then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has set a user password
    Given a verification code delivery has failed for an unconfirmed user
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user pool is created then an admin updates attributes for a confirmed user
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given a user pool has been created
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user pool is deleted then a user account is marked as compromised
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given a user pool has been deleted
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user is created by an admin in an active user pool then a group is created in an active user pool
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given a user has been created by an admin in an active user pool
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user is deleted by an admin then a group is deleted
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given a user has been deleted by an admin
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin confirms a user registration then an admin adds a user to a group in the same pool
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given an admin has confirmed a user registration
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin resets a user password then an admin removes a user from a group
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given an admin has reset a user password
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin sets a user password then a confirmed enabled user initiates authentication
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given an admin has set a user password
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user account is enabled by an admin then a user responds to an auth challenge
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given a user account has been enabled by an admin
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin updates attributes for a confirmed user then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given an admin has updated attributes for a confirmed user
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user account is marked as compromised then an authenticated session expires
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given a user account has been marked as compromised
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a group is created in an active user pool then a verification code delivery fails for an unconfirmed user
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given a group has been created in an active user pool
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a group is deleted then a user pool is created
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given a group has been deleted
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin adds a user to a group in the same pool then a user pool is deleted
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given an admin has added a user to a group in the same pool
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin removes a user from a group then a user is created by an admin in an active user pool
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given an admin has removed a user from a group
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a confirmed enabled user initiates authentication then a user is deleted by an admin
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given a confirmed enabled user has initiated authentication
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a user responds to an auth challenge then an admin confirms a user registration
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given a user has responded to an auth challenge
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an admin initiates authentication on behalf of a confirmed enabled user then an admin resets a user password
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then an authenticated session expires then an admin sets a user password
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given an authenticated session has expired
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is disabled by an admin then a verification code delivery fails for an unconfirmed user then a user account is enabled by an admin
    Given user_id in user_enabled
    Given a user account has been disabled by an admin
    Given a verification code delivery has failed for an unconfirmed user
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user pool is created then a user account is marked as compromised
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given a user pool has been created
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user pool is deleted then a group is created in an active user pool
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given a user pool has been deleted
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user is created by an admin in an active user pool then a group is deleted
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given a user has been created by an admin in an active user pool
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user is deleted by an admin then an admin adds a user to a group in the same pool
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given a user has been deleted by an admin
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin confirms a user registration then an admin removes a user from a group
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given an admin has confirmed a user registration
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin resets a user password then a confirmed enabled user initiates authentication
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given an admin has reset a user password
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin sets a user password then a user responds to an auth challenge
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given an admin has set a user password
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user account is disabled by an admin then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given a user account has been disabled by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin updates attributes for a confirmed user then an authenticated session expires
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given an admin has updated attributes for a confirmed user
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user account is marked as compromised then a verification code delivery fails for an unconfirmed user
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given a user account has been marked as compromised
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a group is created in an active user pool then a user pool is created
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given a group has been created in an active user pool
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a group is deleted then a user pool is deleted
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given a group has been deleted
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin adds a user to a group in the same pool then a user is created by an admin in an active user pool
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given an admin has added a user to a group in the same pool
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin removes a user from a group then a user is deleted by an admin
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given an admin has removed a user from a group
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a confirmed enabled user initiates authentication then an admin confirms a user registration
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given a confirmed enabled user has initiated authentication
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a user responds to an auth challenge then an admin resets a user password
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given a user has responded to an auth challenge
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an admin initiates authentication on behalf of a confirmed enabled user then an admin sets a user password
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then an authenticated session expires then a user account is disabled by an admin
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given an authenticated session has expired
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is enabled by an admin then a verification code delivery fails for an unconfirmed user then an admin updates attributes for a confirmed user
    Given user_id in user_enabled
    Given a user account has been enabled by an admin
    Given a verification code delivery has failed for an unconfirmed user
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user pool is created then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a user pool has been created
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user pool is deleted then a group is deleted
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a user pool has been deleted
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user is created by an admin in an active user pool then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a user has been created by an admin in an active user pool
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user is deleted by an admin then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a user has been deleted by an admin
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin confirms a user registration then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given an admin has confirmed a user registration
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin resets a user password then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given an admin has reset a user password
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin sets a user password then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given an admin has set a user password
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user account is disabled by an admin then an authenticated session expires
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a user account has been disabled by an admin
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user account is enabled by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a user account has been enabled by an admin
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user account is marked as compromised then a user pool is created
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a user account has been marked as compromised
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a group is created in an active user pool then a user pool is deleted
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a group has been created in an active user pool
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a group is deleted then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a group has been deleted
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin adds a user to a group in the same pool then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given an admin has added a user to a group in the same pool
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin removes a user from a group then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given an admin has removed a user from a group
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a confirmed enabled user initiates authentication then an admin resets a user password
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a confirmed enabled user has initiated authentication
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a user responds to an auth challenge then an admin sets a user password
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a user has responded to an auth challenge
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an admin initiates authentication on behalf of a confirmed enabled user then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then an authenticated session expires then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given an authenticated session has expired
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin updates attributes for a confirmed user then a verification code delivery fails for an unconfirmed user then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has updated attributes for a confirmed user
    Given a verification code delivery has failed for an unconfirmed user
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user pool is created then a group is deleted
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given a user pool has been created
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user pool is deleted then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given a user pool has been deleted
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user is created by an admin in an active user pool then an admin removes a user from a group
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given a user has been created by an admin in an active user pool
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user is deleted by an admin then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given a user has been deleted by an admin
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin confirms a user registration then a user responds to an auth challenge
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given an admin has confirmed a user registration
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin resets a user password then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given an admin has reset a user password
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin sets a user password then an authenticated session expires
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given an admin has set a user password
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user account is disabled by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given a user account has been disabled by an admin
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user account is enabled by an admin then a user pool is created
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given a user account has been enabled by an admin
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin updates attributes for a confirmed user then a user pool is deleted
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given an admin has updated attributes for a confirmed user
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a group is created in an active user pool then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given a group has been created in an active user pool
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a group is deleted then a user is deleted by an admin
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given a group has been deleted
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin adds a user to a group in the same pool then an admin confirms a user registration
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given an admin has added a user to a group in the same pool
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin removes a user from a group then an admin resets a user password
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given an admin has removed a user from a group
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a confirmed enabled user initiates authentication then an admin sets a user password
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given a confirmed enabled user has initiated authentication
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a user responds to an auth challenge then a user account is disabled by an admin
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given a user has responded to an auth challenge
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an admin initiates authentication on behalf of a confirmed enabled user then a user account is enabled by an admin
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then an authenticated session expires then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given an authenticated session has expired
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user account is marked as compromised then a verification code delivery fails for an unconfirmed user then a group is created in an active user pool
    Given user_id in user_status
    Given a user account has been marked as compromised
    Given a verification code delivery has failed for an unconfirmed user
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user pool is created then an admin adds a user to a group in the same pool
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given a user pool has been created
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user pool is deleted then an admin removes a user from a group
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given a user pool has been deleted
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user is created by an admin in an active user pool then a confirmed enabled user initiates authentication
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given a user has been created by an admin in an active user pool
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user is deleted by an admin then a user responds to an auth challenge
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given a user has been deleted by an admin
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin confirms a user registration then an admin initiates authentication on behalf of a confirmed enabled user
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given an admin has confirmed a user registration
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin resets a user password then an authenticated session expires
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given an admin has reset a user password
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin sets a user password then a verification code delivery fails for an unconfirmed user
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given an admin has set a user password
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user account is disabled by an admin then a user pool is created
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given a user account has been disabled by an admin
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user account is enabled by an admin then a user pool is deleted
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given a user account has been enabled by an admin
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin updates attributes for a confirmed user then a user is created by an admin in an active user pool
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given an admin has updated attributes for a confirmed user
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user account is marked as compromised then a user is deleted by an admin
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given a user account has been marked as compromised
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a group is deleted then an admin confirms a user registration
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given a group has been deleted
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin adds a user to a group in the same pool then an admin resets a user password
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given an admin has added a user to a group in the same pool
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin removes a user from a group then an admin sets a user password
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given an admin has removed a user from a group
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a confirmed enabled user initiates authentication then a user account is disabled by an admin
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given a confirmed enabled user has initiated authentication
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a user responds to an auth challenge then a user account is enabled by an admin
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given a user has responded to an auth challenge
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an admin initiates authentication on behalf of a confirmed enabled user then an admin updates attributes for a confirmed user
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then an authenticated session expires then a user account is marked as compromised
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given an authenticated session has expired
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is created in an active user pool then a verification code delivery fails for an unconfirmed user then a group is deleted
    Given pool_id in pool_status
    Given a group has been created in an active user pool
    Given a verification code delivery has failed for an unconfirmed user
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user pool is created then an admin removes a user from a group
    Given group_id in group_status
    Given a group has been deleted
    Given a user pool has been created
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user pool is deleted then a confirmed enabled user initiates authentication
    Given group_id in group_status
    Given a group has been deleted
    Given a user pool has been deleted
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user is created by an admin in an active user pool then a user responds to an auth challenge
    Given group_id in group_status
    Given a group has been deleted
    Given a user has been created by an admin in an active user pool
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user is deleted by an admin then an admin initiates authentication on behalf of a confirmed enabled user
    Given group_id in group_status
    Given a group has been deleted
    Given a user has been deleted by an admin
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin confirms a user registration then an authenticated session expires
    Given group_id in group_status
    Given a group has been deleted
    Given an admin has confirmed a user registration
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin resets a user password then a verification code delivery fails for an unconfirmed user
    Given group_id in group_status
    Given a group has been deleted
    Given an admin has reset a user password
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin sets a user password then a user pool is created
    Given group_id in group_status
    Given a group has been deleted
    Given an admin has set a user password
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user account is disabled by an admin then a user pool is deleted
    Given group_id in group_status
    Given a group has been deleted
    Given a user account has been disabled by an admin
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user account is enabled by an admin then a user is created by an admin in an active user pool
    Given group_id in group_status
    Given a group has been deleted
    Given a user account has been enabled by an admin
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin updates attributes for a confirmed user then a user is deleted by an admin
    Given group_id in group_status
    Given a group has been deleted
    Given an admin has updated attributes for a confirmed user
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user account is marked as compromised then an admin confirms a user registration
    Given group_id in group_status
    Given a group has been deleted
    Given a user account has been marked as compromised
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a group is created in an active user pool then an admin resets a user password
    Given group_id in group_status
    Given a group has been deleted
    Given a group has been created in an active user pool
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin adds a user to a group in the same pool then an admin sets a user password
    Given group_id in group_status
    Given a group has been deleted
    Given an admin has added a user to a group in the same pool
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin removes a user from a group then a user account is disabled by an admin
    Given group_id in group_status
    Given a group has been deleted
    Given an admin has removed a user from a group
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a confirmed enabled user initiates authentication then a user account is enabled by an admin
    Given group_id in group_status
    Given a group has been deleted
    Given a confirmed enabled user has initiated authentication
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a user responds to an auth challenge then an admin updates attributes for a confirmed user
    Given group_id in group_status
    Given a group has been deleted
    Given a user has responded to an auth challenge
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an admin initiates authentication on behalf of a confirmed enabled user then a user account is marked as compromised
    Given group_id in group_status
    Given a group has been deleted
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then an authenticated session expires then a group is created in an active user pool
    Given group_id in group_status
    Given a group has been deleted
    Given an authenticated session has expired
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a group is deleted then a verification code delivery fails for an unconfirmed user then an admin adds a user to a group in the same pool
    Given group_id in group_status
    Given a group has been deleted
    Given a verification code delivery has failed for an unconfirmed user
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user pool is created then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a user pool has been created
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user pool is deleted then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a user pool has been deleted
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user is created by an admin in an active user pool then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a user has been created by an admin in an active user pool
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user is deleted by an admin then an authenticated session expires
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a user has been deleted by an admin
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin confirms a user registration then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given an admin has confirmed a user registration
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin resets a user password then a user pool is created
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given an admin has reset a user password
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin sets a user password then a user pool is deleted
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given an admin has set a user password
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user account is disabled by an admin then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a user account has been disabled by an admin
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user account is enabled by an admin then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a user account has been enabled by an admin
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin updates attributes for a confirmed user then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given an admin has updated attributes for a confirmed user
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user account is marked as compromised then an admin resets a user password
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a user account has been marked as compromised
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a group is created in an active user pool then an admin sets a user password
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a group has been created in an active user pool
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a group is deleted then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a group has been deleted
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin removes a user from a group then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given an admin has removed a user from a group
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a confirmed enabled user initiates authentication then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a confirmed enabled user has initiated authentication
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a user responds to an auth challenge then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a user has responded to an auth challenge
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an admin initiates authentication on behalf of a confirmed enabled user then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then an authenticated session expires then a group is deleted
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given an authenticated session has expired
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin adds a user to a group in the same pool then a verification code delivery fails for an unconfirmed user then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has added a user to a group in the same pool
    Given a verification code delivery has failed for an unconfirmed user
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user pool is created then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a user pool has been created
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user pool is deleted then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a user pool has been deleted
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user is created by an admin in an active user pool then an authenticated session expires
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a user has been created by an admin in an active user pool
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user is deleted by an admin then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a user has been deleted by an admin
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin confirms a user registration then a user pool is created
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given an admin has confirmed a user registration
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin resets a user password then a user pool is deleted
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given an admin has reset a user password
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin sets a user password then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given an admin has set a user password
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user account is disabled by an admin then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a user account has been disabled by an admin
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user account is enabled by an admin then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a user account has been enabled by an admin
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin updates attributes for a confirmed user then an admin resets a user password
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given an admin has updated attributes for a confirmed user
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user account is marked as compromised then an admin sets a user password
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a user account has been marked as compromised
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a group is created in an active user pool then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a group has been created in an active user pool
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a group is deleted then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a group has been deleted
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin adds a user to a group in the same pool then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given an admin has added a user to a group in the same pool
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a confirmed enabled user initiates authentication then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a confirmed enabled user has initiated authentication
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a user responds to an auth challenge then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a user has responded to an auth challenge
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an admin initiates authentication on behalf of a confirmed enabled user then a group is deleted
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then an authenticated session expires then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given an authenticated session has expired
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin removes a user from a group then a verification code delivery fails for an unconfirmed user then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has removed a user from a group
    Given a verification code delivery has failed for an unconfirmed user
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user pool is created then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given a user pool has been created
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user pool is deleted then an authenticated session expires
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given a user pool has been deleted
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user is created by an admin in an active user pool then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given a user has been created by an admin in an active user pool
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user is deleted by an admin then a user pool is created
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given a user has been deleted by an admin
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin confirms a user registration then a user pool is deleted
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given an admin has confirmed a user registration
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin resets a user password then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given an admin has reset a user password
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin sets a user password then a user is deleted by an admin
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given an admin has set a user password
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user account is disabled by an admin then an admin confirms a user registration
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given a user account has been disabled by an admin
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user account is enabled by an admin then an admin resets a user password
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given a user account has been enabled by an admin
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin updates attributes for a confirmed user then an admin sets a user password
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given an admin has updated attributes for a confirmed user
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user account is marked as compromised then a user account is disabled by an admin
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given a user account has been marked as compromised
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a group is created in an active user pool then a user account is enabled by an admin
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given a group has been created in an active user pool
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a group is deleted then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given a group has been deleted
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin adds a user to a group in the same pool then a user account is marked as compromised
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given an admin has added a user to a group in the same pool
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin removes a user from a group then a group is created in an active user pool
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given an admin has removed a user from a group
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a user responds to an auth challenge then a group is deleted
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given a user has responded to an auth challenge
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an admin initiates authentication on behalf of a confirmed enabled user then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then an authenticated session expires then an admin removes a user from a group
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given an authenticated session has expired
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a confirmed enabled user initiates authentication then a verification code delivery fails for an unconfirmed user then a user responds to an auth challenge
    Given user_id in user_status
    Given a confirmed enabled user has initiated authentication
    Given a verification code delivery has failed for an unconfirmed user
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user pool is created then an authenticated session expires
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given a user pool has been created
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user pool is deleted then a verification code delivery fails for an unconfirmed user
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given a user pool has been deleted
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user is created by an admin in an active user pool then a user pool is created
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given a user has been created by an admin in an active user pool
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user is deleted by an admin then a user pool is deleted
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given a user has been deleted by an admin
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin confirms a user registration then a user is created by an admin in an active user pool
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given an admin has confirmed a user registration
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin resets a user password then a user is deleted by an admin
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given an admin has reset a user password
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin sets a user password then an admin confirms a user registration
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given an admin has set a user password
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user account is disabled by an admin then an admin resets a user password
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given a user account has been disabled by an admin
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user account is enabled by an admin then an admin sets a user password
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given a user account has been enabled by an admin
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin updates attributes for a confirmed user then a user account is disabled by an admin
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given an admin has updated attributes for a confirmed user
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a user account is marked as compromised then a user account is enabled by an admin
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given a user account has been marked as compromised
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a group is created in an active user pool then an admin updates attributes for a confirmed user
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given a group has been created in an active user pool
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a group is deleted then a user account is marked as compromised
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given a group has been deleted
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin adds a user to a group in the same pool then a group is created in an active user pool
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given an admin has added a user to a group in the same pool
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin removes a user from a group then a group is deleted
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given an admin has removed a user from a group
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a confirmed enabled user initiates authentication then an admin adds a user to a group in the same pool
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given a confirmed enabled user has initiated authentication
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an admin initiates authentication on behalf of a confirmed enabled user then an admin removes a user from a group
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then an authenticated session expires then a confirmed enabled user initiates authentication
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given an authenticated session has expired
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a user responds to an auth challenge then a verification code delivery fails for an unconfirmed user then an admin initiates authentication on behalf of a confirmed enabled user
    Given session_id in session_status
    Given a user has responded to an auth challenge
    Given a verification code delivery has failed for an unconfirmed user
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user pool is created then a verification code delivery fails for an unconfirmed user
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a user pool has been created
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user pool is deleted then a user pool is created
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a user pool has been deleted
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user is created by an admin in an active user pool then a user pool is deleted
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a user has been created by an admin in an active user pool
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user is deleted by an admin then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a user has been deleted by an admin
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin confirms a user registration then a user is deleted by an admin
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given an admin has confirmed a user registration
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin resets a user password then an admin confirms a user registration
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given an admin has reset a user password
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin sets a user password then an admin resets a user password
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given an admin has set a user password
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user account is disabled by an admin then an admin sets a user password
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a user account has been disabled by an admin
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user account is enabled by an admin then a user account is disabled by an admin
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a user account has been enabled by an admin
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin updates attributes for a confirmed user then a user account is enabled by an admin
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given an admin has updated attributes for a confirmed user
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user account is marked as compromised then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a user account has been marked as compromised
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a group is created in an active user pool then a user account is marked as compromised
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a group has been created in an active user pool
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a group is deleted then a group is created in an active user pool
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a group has been deleted
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin adds a user to a group in the same pool then a group is deleted
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given an admin has added a user to a group in the same pool
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an admin removes a user from a group then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given an admin has removed a user from a group
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a confirmed enabled user initiates authentication then an admin removes a user from a group
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a confirmed enabled user has initiated authentication
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a user responds to an auth challenge then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a user has responded to an auth challenge
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then an authenticated session expires then a user responds to an auth challenge
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given an authenticated session has expired
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an admin initiates authentication on behalf of a confirmed enabled user then a verification code delivery fails for an unconfirmed user then an authenticated session expires
    Given user_id in user_status
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    Given a verification code delivery has failed for an unconfirmed user
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user pool is created then a user pool is deleted
    Given session_id in session_status
    Given an authenticated session has expired
    Given a user pool has been created
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user pool is deleted then a user is created by an admin in an active user pool
    Given session_id in session_status
    Given an authenticated session has expired
    Given a user pool has been deleted
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user is created by an admin in an active user pool then a user is deleted by an admin
    Given session_id in session_status
    Given an authenticated session has expired
    Given a user has been created by an admin in an active user pool
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user is deleted by an admin then an admin confirms a user registration
    Given session_id in session_status
    Given an authenticated session has expired
    Given a user has been deleted by an admin
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin confirms a user registration then an admin resets a user password
    Given session_id in session_status
    Given an authenticated session has expired
    Given an admin has confirmed a user registration
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin resets a user password then an admin sets a user password
    Given session_id in session_status
    Given an authenticated session has expired
    Given an admin has reset a user password
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin sets a user password then a user account is disabled by an admin
    Given session_id in session_status
    Given an authenticated session has expired
    Given an admin has set a user password
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user account is disabled by an admin then a user account is enabled by an admin
    Given session_id in session_status
    Given an authenticated session has expired
    Given a user account has been disabled by an admin
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user account is enabled by an admin then an admin updates attributes for a confirmed user
    Given session_id in session_status
    Given an authenticated session has expired
    Given a user account has been enabled by an admin
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin updates attributes for a confirmed user then a user account is marked as compromised
    Given session_id in session_status
    Given an authenticated session has expired
    Given an admin has updated attributes for a confirmed user
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user account is marked as compromised then a group is created in an active user pool
    Given session_id in session_status
    Given an authenticated session has expired
    Given a user account has been marked as compromised
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a group is created in an active user pool then a group is deleted
    Given session_id in session_status
    Given an authenticated session has expired
    Given a group has been created in an active user pool
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a group is deleted then an admin adds a user to a group in the same pool
    Given session_id in session_status
    Given an authenticated session has expired
    Given a group has been deleted
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin adds a user to a group in the same pool then an admin removes a user from a group
    Given session_id in session_status
    Given an authenticated session has expired
    Given an admin has added a user to a group in the same pool
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin removes a user from a group then a confirmed enabled user initiates authentication
    Given session_id in session_status
    Given an authenticated session has expired
    Given an admin has removed a user from a group
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a confirmed enabled user initiates authentication then a user responds to an auth challenge
    Given session_id in session_status
    Given an authenticated session has expired
    Given a confirmed enabled user has initiated authentication
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a user responds to an auth challenge then an admin initiates authentication on behalf of a confirmed enabled user
    Given session_id in session_status
    Given an authenticated session has expired
    Given a user has responded to an auth challenge
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then an admin initiates authentication on behalf of a confirmed enabled user then a verification code delivery fails for an unconfirmed user
    Given session_id in session_status
    Given an authenticated session has expired
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a verification code delivery fails for an unconfirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: an authenticated session expires then a verification code delivery fails for an unconfirmed user then a user pool is created
    Given session_id in session_status
    Given an authenticated session has expired
    Given a verification code delivery has failed for an unconfirmed user
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user pool is created then a user is created by an admin in an active user pool
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given a user pool has been created
    When a user is created by an admin in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user pool is deleted then a user is deleted by an admin
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given a user pool has been deleted
    When a user is deleted by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user is created by an admin in an active user pool then an admin confirms a user registration
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given a user has been created by an admin in an active user pool
    When an admin confirms a user registration
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user is deleted by an admin then an admin resets a user password
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given a user has been deleted by an admin
    When an admin resets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin confirms a user registration then an admin sets a user password
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given an admin has confirmed a user registration
    When an admin sets a user password
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin resets a user password then a user account is disabled by an admin
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given an admin has reset a user password
    When a user account is disabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin sets a user password then a user account is enabled by an admin
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given an admin has set a user password
    When a user account is enabled by an admin
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user account is disabled by an admin then an admin updates attributes for a confirmed user
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given a user account has been disabled by an admin
    When an admin updates attributes for a confirmed user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user account is enabled by an admin then a user account is marked as compromised
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given a user account has been enabled by an admin
    When a user account is marked as compromised
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin updates attributes for a confirmed user then a group is created in an active user pool
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given an admin has updated attributes for a confirmed user
    When a group is created in an active user pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user account is marked as compromised then a group is deleted
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given a user account has been marked as compromised
    When a group is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a group is created in an active user pool then an admin adds a user to a group in the same pool
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given a group has been created in an active user pool
    When an admin adds a user to a group in the same pool
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a group is deleted then an admin removes a user from a group
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given a group has been deleted
    When an admin removes a user from a group
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin adds a user to a group in the same pool then a confirmed enabled user initiates authentication
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given an admin has added a user to a group in the same pool
    When a confirmed enabled user initiates authentication
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin removes a user from a group then a user responds to an auth challenge
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given an admin has removed a user from a group
    When a user responds to an auth challenge
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a confirmed enabled user initiates authentication then an admin initiates authentication on behalf of a confirmed enabled user
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given a confirmed enabled user has initiated authentication
    When an admin initiates authentication on behalf of a confirmed enabled user
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then a user responds to an auth challenge then an authenticated session expires
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given a user has responded to an auth challenge
    When an authenticated session expires
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an admin initiates authentication on behalf of a confirmed enabled user then a user pool is created
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given an admin has initiated authentication on behalf of a confirmed enabled user
    When a user pool is created
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions

  @exhaustive @sequence
  Scenario: a verification code delivery fails for an unconfirmed user then an authenticated session expires then a user pool is deleted
    Given user_id in user_status
    Given a verification code delivery has failed for an unconfirmed user
    Given an authenticated session has expired
    When a user pool is deleted
    Then every user pool has a valid status ("ACTIVE" or "DELETED")
    And every user has a valid status
    And every non-deleted user has an enabled flag set
    And every group membership references an existing active group
    And every auth session has a valid status
    And deleted users do not have active authenticated sessions
    And disabled users do not have active authenticated sessions
