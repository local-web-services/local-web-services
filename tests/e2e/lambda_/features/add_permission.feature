@lambda @add_permission @controlplane @requires_docker
Feature: Lambda AddPermission

  @happy
  Scenario: Add a permission to a Lambda function
    Given a function "e2e-addperm-fn" was created with runtime "python3.12" and handler "handler.handler"
    When I add permission "s3-invoke" to function "e2e-addperm-fn" with action "lambda:InvokeFunction" and principal "s3.amazonaws.com"
    Then the command will succeed
