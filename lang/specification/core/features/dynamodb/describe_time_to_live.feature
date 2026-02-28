@dynamodb @describe_time_to_live @controlplane
Feature: DynamoDB DescribeTimeToLive

  @happy
  Scenario: Describe TTL settings for a table
    Given a table "e2e-desc-ttl" was created
    When I describe time to live for table "e2e-desc-ttl"
    Then the command will succeed
