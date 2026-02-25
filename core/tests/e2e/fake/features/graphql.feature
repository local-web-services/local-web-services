@fake @graphql @controlplane
Feature: Fake GraphQL

  @happy
  Scenario: Create fake server with graphql protocol
    When I create fake server "e2e-fake-graphql-create" with protocol "graphql"
    Then the command will succeed
    And the config will have protocol "graphql"

  @happy
  Scenario: GraphQL server status shows protocol
    Given a fake server "e2e-fake-graphql-status" was created with protocol "graphql"
    When I get status of fake server "e2e-fake-graphql-status"
    Then the command will succeed
    And the output will have protocol "graphql"
