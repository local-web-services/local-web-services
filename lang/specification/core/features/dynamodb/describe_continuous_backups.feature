@dynamodb @describe_continuous_backups @controlplane
Feature: DynamoDB DescribeContinuousBackups

  @happy
  Scenario: Describe continuous backups for a table
    Given a table "e2e-desc-backups" was created
    When I describe continuous backups for table "e2e-desc-backups"
    Then the command will succeed
