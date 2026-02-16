@events @put_events @dataplane
Feature: Events PutEvents

  @happy
  Scenario: Put events to the default bus
    When I put events to the default bus
    Then the command will succeed
    And the failed entry count will be 0
