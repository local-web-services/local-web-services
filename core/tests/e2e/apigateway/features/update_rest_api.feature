@apigateway @update_rest_api @happy @controlplane
Feature: API Gateway UpdateRestApi

  Scenario: Update a REST API name
    Given a REST API "e2e-update-rest-api" was created
    When I update the REST API name to "e2e-updated"
    Then the command will succeed
    And the output "name" will be "e2e-updated"
