@apigateway @delete_method @happy @controlplane
Feature: API Gateway DeleteMethod

  Scenario: Delete a method from a resource
    Given a REST API "e2e-delete-method" was created
    And a resource "temp" was created under the root
    And method "DELETE" was added to the resource
    When I delete method "DELETE" on the resource
    Then the command will succeed
