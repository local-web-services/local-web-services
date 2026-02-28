@apigateway @put_method @happy @controlplane
Feature: API Gateway PutMethod

  Scenario: Put a method on a resource
    Given a REST API "e2e-put-method" was created
    And a resource "orders" was created under the root
    When I put method "GET" on the resource
    Then the command will succeed
    And the output "httpMethod" will be "GET"
