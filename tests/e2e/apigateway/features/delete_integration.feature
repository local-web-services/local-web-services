@apigateway @delete_integration @happy @controlplane
Feature: API Gateway DeleteIntegration

  Scenario: Delete an integration from a method
    Given a REST API "e2e-delete-integration" was created
    And a resource "remove" was created under the root
    And method "POST" was added to the resource
    And integration type "AWS_PROXY" was added to method "POST"
    When I delete integration for method "POST"
    Then the command will succeed
