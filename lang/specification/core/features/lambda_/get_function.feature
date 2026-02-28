@lambda @get_function @controlplane @requires_docker
Feature: Lambda GetFunction

  @happy
  Scenario: Get an existing Lambda function
    Given a function "e2e-get-fn" was created with runtime "python3.12" and handler "handler.handler"
    When I get function "e2e-get-fn"
    Then the command will succeed
