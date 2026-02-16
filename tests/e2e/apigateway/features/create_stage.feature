@apigateway @create_stage @happy @controlplane
Feature: API Gateway CreateStage

  Scenario: Create a stage for a REST API
    Given a REST API "e2e-create-stage" was created
    And a deployment was created for the REST API
    When I create a stage named "e2e-dev" for the REST API
    Then the command will succeed
    And the output "stageName" will be "e2e-dev"
