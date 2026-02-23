@apigateway @delete_resource @happy @controlplane
Feature: API Gateway DeleteResource

  Scenario: Delete a resource from a REST API
    Given a REST API "e2e-delete-resource" was created
    And a resource "to-delete" was created under the root
    When I delete the resource
    Then the command will succeed
