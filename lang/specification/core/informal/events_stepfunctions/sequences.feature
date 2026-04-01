@eventsstepfunctions @generated
Feature: EventsStepfunctions - Action Sequences

  # Generated from FizzBee spec: events_stepfunctions.fizz
  # Safety invariants: RuleReferencesActiveBus, ExecutionRequiresActiveStateMachine, ExecutionRequiresEnabledRule

  Background:
    Given the system is initialized

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "step functions" "state machine" is created
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a "step functions" "state machine" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "bus" is created then a running "step functions" "execution" completes successfully
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "bus" is created then a running "step functions" "execution" fails
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" fails
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "eventbridge" "bus" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" completes successfully
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an "eventbridge" "bus" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a "step functions" "state machine" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a "step functions" "state machine" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" completes successfully
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" fails
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" fails
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then an "eventbridge" "bus" is created
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then a "step functions" "state machine" is created
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When a "step functions" "state machine" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then a running "step functions" "execution" completes successfully
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then a running "step functions" "execution" fails
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When a running "step functions" "execution" fails
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an "eventbridge" "bus" is created
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a running "step functions" "execution" fails
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a running "step functions" "execution" fails
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" fails then an "eventbridge" "bus" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" fails then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When a "step functions" "state machine" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" fails then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" fails then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" fails then a running "step functions" "execution" completes successfully
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "step functions" "state machine" is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a "step functions" "state machine" is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "bus" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then a running "step functions" "execution" completes successfully
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "bus" is created then a running "step functions" "execution" completes successfully then a running "step functions" "execution" fails
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" completes successfully
    When a running "step functions" "execution" fails
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "bus" is created then a running "step functions" "execution" fails then a "step functions" "state machine" is created
    Given bid not in bus_status
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" fails
    When a "step functions" "state machine" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "eventbridge" "bus" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "eventbridge" "bus" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" completes successfully
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a "step functions" "state machine" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then a running "step functions" "execution" fails
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When a running "step functions" "execution" fails
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" completes successfully then an "eventbridge" "bus" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" completes successfully
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an "eventbridge" "bus" is created then a running "step functions" "execution" completes successfully
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a "step functions" "state machine" is created then a running "step functions" "execution" fails
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then an "eventbridge" "bus" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" completes successfully then a "step functions" "state machine" is created
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" fails then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Given rid not in rule_status
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" fails
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then an "eventbridge" "bus" is created then a running "step functions" "execution" fails
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When an "eventbridge" "bus" is created
    When a running "step functions" "execution" fails
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then a "step functions" "state machine" is created then an "eventbridge" "bus" is created
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When a "step functions" "state machine" is created
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a "step functions" "state machine" is created
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a "step functions" "state machine" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then a running "step functions" "execution" completes successfully then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When a running "step functions" "execution" completes successfully
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then a running "step functions" "execution" fails then a running "step functions" "execution" completes successfully
    Given bid in bus_status
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When a running "step functions" "execution" fails
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an "eventbridge" "bus" is created then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an "eventbridge" "bus" is created
    When a "step functions" "state machine" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a "step functions" "state machine" is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an "eventbridge" "rule" is created to start a Step Functions execution on matching events then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then a running "step functions" "execution" fails
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When a running "step functions" "execution" fails
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" completes successfully then a running "step functions" "execution" fails then an "eventbridge" "bus" is created
    Given eid in exec_status
    When a running "step functions" "execution" completes successfully
    When a running "step functions" "execution" fails
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" fails then an "eventbridge" "bus" is created then an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an "eventbridge" "bus" is created
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" fails then a "step functions" "state machine" is created then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When a "step functions" "state machine" is created
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" fails then an "eventbridge" "rule" is created to start a Step Functions execution on matching events then a running "step functions" "execution" completes successfully
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an "eventbridge" "rule" is created to start a Step Functions execution on matching events
    When a running "step functions" "execution" completes successfully
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" fails then an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution" then an "eventbridge" "bus" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When an "eventbridge" "event" is published to the "eventbridge" "bus" and triggers a new "step functions" "execution"
    When an "eventbridge" "bus" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"

  @sequence
  Scenario: a running "step functions" "execution" fails then a running "step functions" "execution" completes successfully then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails
    When a running "step functions" "execution" completes successfully
    When a "step functions" "state machine" is created
    And every "ENABLED" "eventbridge" "rule" references an "ACTIVE" "eventbridge" "bus"
    And every "RUNNING" "step functions" "execution" references an "ACTIVE" "step functions" "state machine"
    And every "RUNNING" "step functions" "execution" was started by an "ENABLED" "eventbridge" "rule"
