@stepfunctions @jsonata_expression @dataplane
Feature: Step Functions JSONata Expression Evaluation

  @minimal @happy @jsonata_expression
  Scenario: Execute a Pass state using JSONata Arguments to transform input
    Given a JSONata "step functions" "state machine" is created
    When a synchronous execution is started on an express "step functions" "state machine"
    Then the "step functions" "execution" will be "SUCCEEDED" or "FAILED"
    And the sync execution output will contain "result_key"
