@apigateway @get_deployment @happy @controlplane
Feature: API Gateway GetDeployment

  Scenario: Get a deployment by ID
    Given a REST API "e2e-get-deployment" was created
    And a deployment was created for the REST API
    When I get the deployment
    Then the command will succeed
    And the output "id" will match the deployment ID
