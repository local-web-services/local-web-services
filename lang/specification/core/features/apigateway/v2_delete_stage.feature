@apigateway @v2_delete_stage @happy @controlplane @v2
Feature: API Gateway V2 DeleteStage

  Scenario: Delete a stage from an HTTP API
    Given a V2 API "e2e-v2-delete-stage" was created
    And a V2 stage named "to-delete" was created
    When I delete V2 stage "to-delete"
    Then the command will succeed
