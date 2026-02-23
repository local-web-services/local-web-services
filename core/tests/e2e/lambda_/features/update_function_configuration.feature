@lambda @update_function_configuration @controlplane @requires_docker
Feature: Lambda UpdateFunctionConfiguration

  @happy
  Scenario: Update function configuration
    Given a function "e2e-upd-cfg-fn" was created with runtime "python3.12" and handler "handler.handler"
    When I update function configuration for "e2e-upd-cfg-fn" with timeout "60"
    Then the command will succeed
    And function "e2e-upd-cfg-fn" will have timeout 60
