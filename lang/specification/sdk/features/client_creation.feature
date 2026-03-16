@sdk @client_creation
Feature: AWS client creation

  Clients returned by the session are pre-configured to point at the
  local service endpoints — no manual endpoint or credential setup required.

  @happy
  Scenario Outline: Client for <service> is returned and usable
    Given a running session
    When I request a client for "<service>"
    Then a configured client is returned
    And the client can successfully call the <service> service

    Examples:
      | service          |
      | dynamodb         |
      | sqs              |
      | s3               |
      | sns              |
      | stepfunctions    |
      | ssm              |
      | secretsmanager   |
