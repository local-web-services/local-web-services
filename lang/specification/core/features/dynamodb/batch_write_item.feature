@dynamodb @batch_write_item @dataplane
Feature: DynamoDB BatchWriteItem

  @happy
  Scenario: Batch write items into a table
    Given a table "e2e-batch-write" was created
    When I batch write items with keys "bw1" and "bw2" into table "e2e-batch-write"
    Then the command will succeed
