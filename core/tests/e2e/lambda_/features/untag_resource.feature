@lambda @untag_resource @controlplane @requires_docker
Feature: Lambda UntagResource

  @happy
  Scenario: Untag a Lambda function
    Given a function "e2e-untag-fn" was created with runtime "python3.12" and handler "handler.handler"
    And function "e2e-untag-fn" was tagged with key "env" and value "test"
    When I untag function "e2e-untag-fn" removing key "env"
    Then the command will succeed
    And function "e2e-untag-fn" will not have tag "env"
