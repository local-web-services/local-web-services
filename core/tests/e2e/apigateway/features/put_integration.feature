@apigateway @put_integration @happy @controlplane
Feature: API Gateway PutIntegration

  Scenario: Put an integration on a method
    Given a REST API "e2e-put-integration" was created
    And a resource "items" was created under the root
    And method "POST" was added to the resource
    When I put integration type "AWS_PROXY" on method "POST"
    Then the command will succeed
    And the output "type" will be "AWS_PROXY"
