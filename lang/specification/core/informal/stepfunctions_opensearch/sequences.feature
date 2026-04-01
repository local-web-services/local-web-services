@stepfunctionsopensearch @generated
Feature: StepfunctionsOpensearch - Action Sequences

  # Generated from FizzBee spec: stepfunctions_opensearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "opensearch" "domain" configuration update begins
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then the "opensearch" "domain" configuration update completes
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then a "step functions" "state machine" is created
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then a "opensearch" "domain" configuration update begins
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then the "opensearch" "domain" configuration update completes
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then a "step functions" "state machine" is created
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then the "opensearch" "domain" configuration update completes
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then a "step functions" "state machine" is created
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then a "opensearch" "domain" configuration update begins
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "opensearch" "domain" configuration update begins
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "opensearch" "domain" configuration update completes
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then a "opensearch" "domain" configuration update begins
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then the "opensearch" "domain" configuration update completes
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then a "opensearch" "domain" configuration update begins
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then the "opensearch" "domain" configuration update completes
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then an "opensearch" "domain" is created and becomes "ACTIVE" then a "opensearch" "domain" configuration update begins
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "opensearch" "domain" configuration update begins then the "opensearch" "domain" configuration update completes
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "opensearch" "domain" configuration update begins
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then the "opensearch" "domain" configuration update completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "opensearch" "domain" configuration update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then a "step functions" "state machine" is created then the "opensearch" "domain" configuration update completes
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a "step functions" "state machine" is created
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then a "opensearch" "domain" configuration update begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a "opensearch" "domain" configuration update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then the "opensearch" "domain" configuration update completes then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When the "opensearch" "domain" configuration update completes
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then a "step functions" "state machine" is created
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "opensearch" "domain" is created and becomes "ACTIVE" then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then a "opensearch" "domain" configuration update begins
    Given did not in domain_status
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then an "opensearch" "domain" is created and becomes "ACTIVE" then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then the "opensearch" "domain" configuration update completes then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When the "opensearch" "domain" configuration update completes
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "opensearch" "domain" configuration update begins then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then the "opensearch" "domain" configuration update completes
    Given did in domain_status
    When a "opensearch" "domain" configuration update begins
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then a "step functions" "state machine" is created then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then an "opensearch" "domain" is created and becomes "ACTIVE" then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then a "opensearch" "domain" configuration update begins then a "step functions" "state machine" is created
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When a "opensearch" "domain" configuration update begins
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then an "step functions" "execution" of the "step functions" "state machine" is started then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then a "opensearch" "domain" configuration update begins
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "opensearch" "domain" configuration update completes then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did in domain_status
    When the "opensearch" "domain" configuration update completes
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then an "opensearch" "domain" is created and becomes "ACTIVE" then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "opensearch" "domain" configuration update begins then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "opensearch" "domain" configuration update begins
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "opensearch" "domain" configuration update completes then a "opensearch" "domain" configuration update begins
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "opensearch" "domain" configuration update completes
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then the "opensearch" "domain" configuration update completes
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then a "step functions" "state machine" is created then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a "step functions" "state machine" is created
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then an "opensearch" "domain" is created and becomes "ACTIVE" then a "opensearch" "domain" configuration update begins
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then a "opensearch" "domain" configuration update begins then the "opensearch" "domain" configuration update completes
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a "opensearch" "domain" configuration update begins
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then the "opensearch" "domain" configuration update completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When the "opensearch" "domain" configuration update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then a "step functions" "state machine" is created then a "opensearch" "domain" configuration update begins
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When a "step functions" "state machine" is created
    When a "opensearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then an "opensearch" "domain" is created and becomes "ACTIVE" then the "opensearch" "domain" configuration update completes
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    When the "opensearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then a "opensearch" "domain" configuration update begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When a "opensearch" "domain" configuration update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then the "opensearch" "domain" configuration update completes then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When the "opensearch" "domain" configuration update completes
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update then a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds then an "opensearch" "domain" is created and becomes "ACTIVE"
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "opensearch" "domain" is processing a config update
    When a running "step functions" "execution" calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an "opensearch" "domain" is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called
