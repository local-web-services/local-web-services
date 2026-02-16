@apigateway @create_resource @happy @controlplane
Feature: API Gateway CreateResource

  Scenario: Create a resource under the root
    Given a REST API "e2e-create-resource" was created
    When I create a resource with path part "items" under the root
    Then the command will succeed
    And the output "path" will be "/items"
