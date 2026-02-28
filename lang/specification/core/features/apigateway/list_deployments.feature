@apigateway @list_deployments @happy @controlplane
Feature: API Gateway ListDeployments

  Scenario: List deployments for a REST API
    Given a REST API "e2e-list-deployments" was created
    And a deployment was created for the REST API
    When I list deployments for the REST API
    Then the command will succeed
    And the output will contain an "item" list with at least 1 entry
