@lambda @remove_permission @controlplane @requires_docker
Feature: Lambda RemovePermission

  @happy
  Scenario: Remove a permission from a Lambda function
    Given a function "e2e-rmperm-fn" was created with runtime "python3.12" and handler "handler.handler"
    And permission "s3-invoke" was added to function "e2e-rmperm-fn"
    When I remove permission "s3-invoke" from function "e2e-rmperm-fn"
    Then the command will succeed
    And function "e2e-rmperm-fn" will not have permission "s3-invoke" in its policy
