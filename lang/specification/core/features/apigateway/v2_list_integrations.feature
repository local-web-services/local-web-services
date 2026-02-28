@apigateway @v2_list_integrations @happy @controlplane @v2
Feature: API Gateway V2 ListIntegrations

  Scenario: List integrations for an HTTP API
    Given a V2 API "e2e-v2-list-ints" was created
    And a V2 integration with type "AWS_PROXY" was created
    When I list V2 integrations
    Then the command will succeed
    And the output will contain an "items" list with at least 1 entry
