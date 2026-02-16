@apigateway @v2_update_stage @happy @controlplane @v2
Feature: API Gateway V2 UpdateStage

  Scenario: Update a stage for an HTTP API
    Given a V2 API "e2e-v2-update-stage" was created
    And a V2 stage named "e2e-prod" was created
    When I update V2 stage "e2e-prod"
    Then the command will succeed
    And the output "stageName" will be "e2e-prod"
