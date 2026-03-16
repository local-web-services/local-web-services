@sdk @session_lifecycle
Feature: Session lifecycle

  @happy
  Scenario: Create a session with default options and close it
    When I create a session
    Then the session is running
    When I close the session
    Then the session is closed

  @happy
  Scenario: Session can be used as a context manager
    When I open a session as a context manager
    Then the session is running inside the context
    And the session is closed after the context exits
