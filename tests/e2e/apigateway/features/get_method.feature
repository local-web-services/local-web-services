@apigateway @get_method @happy @controlplane
Feature: API Gateway GetMethod

  Scenario: Get a method on a resource
    Given a REST API "e2e-get-method" was created
    And a resource "products" was created under the root
    And method "GET" was added to the resource
    When I get method "GET" on the resource
    Then the command will succeed
    And the output "httpMethod" will be "GET"
