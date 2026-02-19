@stepfunctions @untag_resource @controlplane
Feature: StepFunctions UntagResource

  @happy
  Scenario: Untag a state machine resource
    Given a state machine "e2e-untag-sm" was created with a Pass definition
    And state machine "e2e-untag-sm" was tagged with tags [{"key": "env", "value": "test"}]
    When I untag state machine "e2e-untag-sm" with tag keys ["env"]
    Then the command will succeed
    And state machine "e2e-untag-sm" will not have tag "env"
