@stepfunctions @list_tags_for_resource @controlplane
Feature: StepFunctions ListTagsForResource

  @happy
  Scenario: List tags for a state machine resource
    Given a state machine "e2e-list-tags-sm" was created with a Pass definition
    When I list tags for state machine "e2e-list-tags-sm"
    Then the command will succeed
