@cognitoevents @generated
Feature: CognitoEvents - A Cognito User Pool Is Created

  # Generated from FizzBee spec: cognito_events.fizz
  # Safety invariants: DeliveredEventReferencesExistingPool, DeliveredEventReferencesExistingBus

  Background:
    Given the system is initialized

  @minimal @happy @create_user_pool
  Scenario: a Cognito user pool is created
    Given the pool does not already exist
    When a Cognito user pool is created
    Then the pool is "ACTIVE" with no EventBridge configuration
    And every "DELIVERED" event references a pool that exists
    And every "DELIVERED" event references a bus that exists

  @standard @negative @create_user_pool
  Scenario: a Cognito user pool is created fails when the pool already exists
    Given the pool already exists
    When a Cognito user pool is created
    Then the operation is rejected
