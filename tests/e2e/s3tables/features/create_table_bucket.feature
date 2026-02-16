@s3tables @create_table_bucket @controlplane
Feature: S3Tables CreateTableBucket

  @happy
  Scenario: Create a new table bucket
    When I create table bucket "e2e-create-tb"
    Then the command will succeed
    And the table bucket list will include "e2e-create-tb"
