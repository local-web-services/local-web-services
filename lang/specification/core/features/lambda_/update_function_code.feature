@lambda @update_function_code @controlplane @requires_docker
Feature: Lambda UpdateFunctionCode

  @happy
  Scenario: Update function code
    Given a function "e2e-upd-code-fn" was created with runtime "python3.12" and handler "handler.handler"
    When I update function code for "e2e-upd-code-fn"
    Then the command will succeed
