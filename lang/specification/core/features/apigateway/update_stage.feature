@apigateway @update_stage @happy @controlplane
Feature: API Gateway UpdateStage

  Scenario: Update a stage
    Given a REST API "e2e-update-stage" was created
    And a deployment was created for the REST API
    And a stage named "e2e-prod" was created for the REST API
    When I update stage "e2e-prod" for the REST API
    Then the command will succeed
    And the output "stageName" will be "e2e-prod"
