@sns @confirm_subscription @controlplane
Feature: SNS ConfirmSubscription

  @happy
  Scenario: Confirm a subscription with a token
    Given a topic "e2e-confirm-sub" was created
    When I confirm subscription for topic "e2e-confirm-sub" with token "dummy-token"
    Then the command will succeed
