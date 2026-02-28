@stepfunctions @tag_resource @controlplane
Feature: StepFunctions TagResource

  @happy
  Scenario: Tag a state machine resource
    Given a state machine "e2e-tag-sm" was created with a Pass definition
    When I tag state machine "e2e-tag-sm" with tags [{"key": "env", "value": "test"}]
    Then the command will succeed
    And state machine "e2e-tag-sm" will have tag "env" with value "test"
