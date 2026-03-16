@sdk @cdk_discovery
Feature: CDK resource discovery

  @happy
  Scenario: Session started from CDK output directory has declared resources available
    When I create a session from the "cdk.out" CDK directory
    Then the session is running
    And the resources declared in the CDK stack are available
