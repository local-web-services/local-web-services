@lambda @list_tags @controlplane @requires_docker
Feature: Lambda ListTags

  @happy
  Scenario: List tags for a Lambda function
    Given a function "e2e-listtags-fn" was created with runtime "python3.12" and handler "handler.handler"
    And function "e2e-listtags-fn" was tagged with key "env" and value "prod"
    When I list tags for function "e2e-listtags-fn"
    Then the command will succeed
