@lambda @list_functions @controlplane
Feature: Lambda ListFunctions

  @happy
  Scenario: List Lambda functions
    When I list functions
    Then the command will succeed
