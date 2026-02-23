@apigateway @delete_rest_api @happy @controlplane
Feature: API Gateway DeleteRestApi

  Scenario: Delete a REST API
    Given a REST API "e2e-delete-rest-api" was created
    When I delete the REST API
    Then the command will succeed
