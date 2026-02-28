@s3tables @create_table @controlplane
Feature: S3Tables CreateTable

  @happy
  Scenario: Create a table in a namespace
    Given a table bucket "e2e-tbl-lifecycle-tb" was created
    And a namespace "e2e-tbl-ns" was created in table bucket "e2e-tbl-lifecycle-tb"
    When I create table "e2e-events" in namespace "e2e-tbl-ns" of table bucket "e2e-tbl-lifecycle-tb"
    Then the command will succeed
    And the table list in namespace "e2e-tbl-ns" of table bucket "e2e-tbl-lifecycle-tb" will include "e2e-events"
