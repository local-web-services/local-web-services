@apigateway @delete_stage @happy @controlplane
Feature: API Gateway DeleteStage

  Scenario: Delete a stage from a REST API
    Given a REST API "e2e-delete-stage" was created
    And a deployment was created for the REST API
    And a stage named "to-delete" was created for the REST API
    When I delete stage "to-delete" for the REST API
    Then the command will succeed
