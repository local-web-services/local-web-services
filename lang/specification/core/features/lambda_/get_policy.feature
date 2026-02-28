@lambda @get_policy @controlplane @requires_docker
Feature: Lambda GetPolicy

  @happy
  Scenario: Get a Lambda function policy
    Given a function "e2e-getpol-fn" was created with runtime "python3.12" and handler "handler.handler"
    When I get the policy of function "e2e-getpol-fn"
    Then the command will succeed
