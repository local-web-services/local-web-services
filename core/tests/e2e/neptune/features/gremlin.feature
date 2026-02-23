@neptune @gremlin @dataplane
Feature: Neptune Gremlin endpoint

  @happy
  Scenario: Created Neptune cluster has an endpoint
    When I create a Neptune DB cluster "e2e-neptune-gremlin"
    Then the command will succeed
    And the output will contain a non-empty Endpoint field
