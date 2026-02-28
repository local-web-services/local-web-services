@lambda @delete_function @controlplane @requires_docker
Feature: Lambda DeleteFunction

  @happy
  Scenario: Delete an existing Lambda function
    Given a function "e2e-del-fn" was created with runtime "python3.12" and handler "handler.handler"
    When I delete function "e2e-del-fn"
    Then the command will succeed
    And function "e2e-del-fn" will not appear in list-functions
