@lambda @create_function @controlplane @requires_docker
Feature: Lambda CreateFunction

  @happy
  Scenario: Create a new Lambda function
    When I create function "e2e-create-fn" with runtime "python3.12" and handler "handler.handler"
    Then the command will succeed
    And function "e2e-create-fn" will appear in list-functions
