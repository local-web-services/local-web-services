@chaos @enable_disable @controlplane
Feature: Chaos enable and disable

  @happy
  Scenario: Enable chaos for dynamodb
    When I enable chaos for "dynamodb"
    Then the command will succeed
    And chaos for "dynamodb" will be enabled

  @happy
  Scenario: Disable chaos for dynamodb
    Given chaos was enabled for "dynamodb"
    When I disable chaos for "dynamodb"
    Then the command will succeed
    And chaos for "dynamodb" will be disabled

  @happy
  Scenario: Show chaos status for all services
    When I request chaos status
    Then the command will succeed
    And the chaos status will contain "dynamodb"
    And the chaos status will contain "s3"
