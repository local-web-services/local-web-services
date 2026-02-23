@apigateway @get_stage @happy @controlplane
Feature: API Gateway GetStage

  Scenario: Get a stage by name
    Given a REST API "e2e-get-stage" was created
    And a deployment was created for the REST API
    And a stage named "e2e-staging" was created for the REST API
    When I get stage "e2e-staging" for the REST API
    Then the command will succeed
    And the output "stageName" will be "e2e-staging"
