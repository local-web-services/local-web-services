@lambda @tag_resource @controlplane @requires_docker
Feature: Lambda TagResource

  @happy
  Scenario: Tag a Lambda function
    Given a function "e2e-tag-fn" was created with runtime "python3.12" and handler "handler.handler"
    When I tag function "e2e-tag-fn" with key "env" and value "test"
    Then the command will succeed
    And function "e2e-tag-fn" will have tag "env" with value "test"
