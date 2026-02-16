@apigateway @create_deployment @happy @controlplane
Feature: API Gateway CreateDeployment

  Scenario: Create a deployment for a REST API
    Given a REST API "e2e-create-deployment" was created
    When I create a deployment for the REST API
    Then the command will succeed
    And the output will contain an "id" field
