@apigateway @v2_create_stage @happy @controlplane @v2
Feature: API Gateway V2 CreateStage

  Scenario: Create a stage for an HTTP API
    Given a V2 API "e2e-v2-create-stage" was created
    When I create a V2 stage named "e2e-dev"
    Then the command will succeed
    And the output "stageName" will be "e2e-dev"
