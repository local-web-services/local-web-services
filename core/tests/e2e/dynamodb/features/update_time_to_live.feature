@dynamodb @update_time_to_live @controlplane
Feature: DynamoDB UpdateTimeToLive

  @happy
  Scenario: Update TTL settings for a table
    Given a table "e2e-upd-ttl" was created
    When I update time to live for table "e2e-upd-ttl"
    Then the command will succeed
