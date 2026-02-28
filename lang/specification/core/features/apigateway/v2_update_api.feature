@apigateway @v2_update_api @happy @controlplane @v2
Feature: API Gateway V2 UpdateApi

  Scenario: Update an HTTP API name
    Given a V2 API "e2e-v2-update-api" was created
    When I update the V2 API name to "e2e-v2-updated"
    Then the command will succeed
    And the output "name" will be "e2e-v2-updated"
