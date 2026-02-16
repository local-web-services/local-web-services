@apigateway @v2_delete_api @happy @controlplane @v2
Feature: API Gateway V2 DeleteApi

  Scenario: Delete an HTTP API
    Given a V2 API "e2e-v2-delete-api" was created
    When I delete the V2 API
    Then the command will succeed
