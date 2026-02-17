@mock @graphql @controlplane
Feature: Mock GraphQL

  @happy
  Scenario: Create mock server with graphql protocol
    When I create mock server "e2e-mock-graphql-create" with protocol "graphql"
    Then the command will succeed
    And the config will have protocol "graphql"

  @happy
  Scenario: GraphQL server status shows protocol
    Given a mock server "e2e-mock-graphql-status" was created with protocol "graphql"
    When I get status of mock server "e2e-mock-graphql-status"
    Then the command will succeed
    And the output will have protocol "graphql"
