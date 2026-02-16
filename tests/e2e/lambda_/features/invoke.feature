@lambda @invoke @error @dataplane
Feature: Lambda Invoke

  @error
  Scenario: Invoke a non-existent function returns an error message
    When I invoke function "e2e-nonexistent-fn"
    Then the command will succeed
    And the output will contain an error message
