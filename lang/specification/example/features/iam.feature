@iam @process_order @controlplane
Feature: IAM enforce mode controls access to AWS operations

  @happy @minimal
  Scenario: Wildcard allow policy permits order processing
    Given an OrderProcessor state machine is running
    And IAM is in enforce mode with identity "test-user" allowed all actions on all resources
    When I process order "order-iam-001"
    Then the output will contain order ID "order-iam-001"
