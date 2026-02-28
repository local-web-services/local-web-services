@apigateway @create_rest_api @happy @controlplane
Feature: API Gateway CreateRestApi

  Scenario: Create a new REST API
    When I create a REST API named "e2e-create-rest-api"
    Then the command will succeed
    And the output will contain an "id" field
    And the output "name" will be "e2e-create-rest-api"
