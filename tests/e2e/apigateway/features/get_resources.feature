@apigateway @get_resources @happy @controlplane
Feature: API Gateway GetResources

  Scenario: Get resources for a REST API
    Given a REST API "e2e-get-resources" was created
    When I get resources for the REST API
    Then the command will succeed
    And the output will contain an "item" list with at least 1 entry
