@apigateway @get_integration @happy @controlplane
Feature: API Gateway GetIntegration

  Scenario: Get an integration on a method
    Given a REST API "e2e-get-integration" was created
    And a resource "data" was created under the root
    And method "GET" was added to the resource
    And integration type "AWS_PROXY" was added to method "GET"
    When I get integration for method "GET"
    Then the command will succeed
    And the output "type" will be "AWS_PROXY"
