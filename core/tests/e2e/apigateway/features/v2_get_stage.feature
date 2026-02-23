@apigateway @v2_get_stage @happy @controlplane @v2
Feature: API Gateway V2 GetStage

  Scenario: Get a stage by name
    Given a V2 API "e2e-v2-get-stage" was created
    And a V2 stage named "e2e-staging" was created
    When I get V2 stage "e2e-staging"
    Then the command will succeed
    And the output "stageName" will be "e2e-staging"
