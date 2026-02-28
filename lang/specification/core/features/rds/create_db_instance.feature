@rds @create_db_instance @controlplane
Feature: RDS CreateDBInstance

  @happy
  Scenario: Create a new DB instance
    When I create a DB instance "e2e-rds-create-instance"
    Then the command will succeed
    And DB instance "e2e-rds-create-instance" will exist

  @happy
  Scenario: Delete an existing DB instance
    Given a DB instance "e2e-rds-create-del" was created
    When I delete DB instance "e2e-rds-create-del"
    Then the command will succeed
    And DB instance "e2e-rds-create-del" will not exist

  @happy
  Scenario: Describe DB instances
    Given a DB instance "e2e-rds-describe" was created
    When I describe DB instances
    Then the command will succeed
    And DB instance "e2e-rds-describe" will appear in the output
