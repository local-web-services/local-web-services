@apigateway @get_rest_api @happy @controlplane
Feature: API Gateway GetRestApi

  Scenario: Get a REST API by ID
    Given a REST API "e2e-get-rest-api" was created
    When I get the REST API
    Then the command will succeed
    And the output "name" will be "e2e-get-rest-api"
