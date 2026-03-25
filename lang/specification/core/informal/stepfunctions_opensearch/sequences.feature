@stepfunctionsopensearch @generated
Feature: StepfunctionsOpensearch - Action Sequences

  # Generated from FizzBee spec: stepfunctions_opensearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an OpenSearch domain is created and becomes "ACTIVE"
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a domain configuration update begins
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the domain configuration update completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the domain is processing a config update
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a Step Functions state machine is created
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a domain configuration update begins
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then the domain configuration update completes
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then an execution of the state machine is started
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a running execution fails because the domain is processing a config update
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a Step Functions state machine is created
    Given did in domain_status
    When a domain configuration update begins
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an OpenSearch domain is created and becomes "ACTIVE"
    Given did in domain_status
    When a domain configuration update begins
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the domain configuration update completes
    Given did in domain_status
    When a domain configuration update begins
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an execution of the state machine is started
    Given did in domain_status
    When a domain configuration update begins
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    When a domain configuration update begins
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a running execution fails because the domain is processing a config update
    Given did in domain_status
    When a domain configuration update begins
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a Step Functions state machine is created
    Given did in domain_status
    When the domain configuration update completes
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an OpenSearch domain is created and becomes "ACTIVE"
    Given did in domain_status
    When the domain configuration update completes
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a domain configuration update begins
    Given did in domain_status
    When the domain configuration update completes
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an execution of the state machine is started
    Given did in domain_status
    When the domain configuration update completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    When the domain configuration update completes
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a running execution fails because the domain is processing a config update
    Given did in domain_status
    When the domain configuration update completes
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an OpenSearch domain is created and becomes "ACTIVE"
    Given smid in sm_status
    When an execution of the state machine is started
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a domain configuration update begins
    Given smid in sm_status
    When an execution of the state machine is started
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the domain configuration update completes
    Given smid in sm_status
    When an execution of the state machine is started
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the domain is processing a config update
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an OpenSearch domain is created and becomes "ACTIVE"
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a domain configuration update begins
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then the domain configuration update completes
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a running execution fails because the domain is processing a config update
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then an OpenSearch domain is created and becomes "ACTIVE"
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a domain configuration update begins
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then the domain configuration update completes
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an OpenSearch domain is created and becomes "ACTIVE" then a domain configuration update begins
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a domain configuration update begins then the domain configuration update completes
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a domain configuration update begins
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the domain configuration update completes then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When the domain configuration update completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a running execution fails because the domain is processing a config update
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the domain is processing a config update then an OpenSearch domain is created and becomes "ACTIVE"
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails because the domain is processing a config update
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a Step Functions state machine is created then the domain configuration update completes
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a Step Functions state machine is created
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a domain configuration update begins then an execution of the state machine is started
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a domain configuration update begins
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then the domain configuration update completes then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When the domain configuration update completes
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then an execution of the state machine is started then a running execution fails because the domain is processing a config update
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When an execution of the state machine is started
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a Step Functions state machine is created
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a running execution fails because the domain is processing a config update then a domain configuration update begins
    Given did not in domain_status
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a running execution fails because the domain is processing a config update
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a Step Functions state machine is created then an execution of the state machine is started
    Given did in domain_status
    When a domain configuration update begins
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an OpenSearch domain is created and becomes "ACTIVE" then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    When a domain configuration update begins
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the domain configuration update completes then a running execution fails because the domain is processing a config update
    Given did in domain_status
    When a domain configuration update begins
    When the domain configuration update completes
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an execution of the state machine is started then a Step Functions state machine is created
    Given did in domain_status
    When a domain configuration update begins
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an OpenSearch domain is created and becomes "ACTIVE"
    Given did in domain_status
    When a domain configuration update begins
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a running execution fails because the domain is processing a config update then the domain configuration update completes
    Given did in domain_status
    When a domain configuration update begins
    When a running execution fails because the domain is processing a config update
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a Step Functions state machine is created then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    When the domain configuration update completes
    When a Step Functions state machine is created
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an OpenSearch domain is created and becomes "ACTIVE" then a running execution fails because the domain is processing a config update
    Given did in domain_status
    When the domain configuration update completes
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a domain configuration update begins then a Step Functions state machine is created
    Given did in domain_status
    When the domain configuration update completes
    When a domain configuration update begins
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an execution of the state machine is started then an OpenSearch domain is created and becomes "ACTIVE"
    Given did in domain_status
    When the domain configuration update completes
    When an execution of the state machine is started
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a domain configuration update begins
    Given did in domain_status
    When the domain configuration update completes
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a running execution fails because the domain is processing a config update then an execution of the state machine is started
    Given did in domain_status
    When the domain configuration update completes
    When a running execution fails because the domain is processing a config update
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails because the domain is processing a config update
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an OpenSearch domain is created and becomes "ACTIVE" then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a domain configuration update begins then an OpenSearch domain is created and becomes "ACTIVE"
    Given smid in sm_status
    When an execution of the state machine is started
    When a domain configuration update begins
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the domain configuration update completes then a domain configuration update begins
    Given smid in sm_status
    When an execution of the state machine is started
    When the domain configuration update completes
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then the domain configuration update completes
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the domain is processing a config update then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails because the domain is processing a config update
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a Step Functions state machine is created then an OpenSearch domain is created and becomes "ACTIVE"
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a Step Functions state machine is created
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an OpenSearch domain is created and becomes "ACTIVE" then a domain configuration update begins
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an OpenSearch domain is created and becomes "ACTIVE"
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a domain configuration update begins then the domain configuration update completes
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a domain configuration update begins
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then the domain configuration update completes then an execution of the state machine is started
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When the domain configuration update completes
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an execution of the state machine is started then a running execution fails because the domain is processing a config update
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an execution of the state machine is started
    When a running execution fails because the domain is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a running execution fails because the domain is processing a config update then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When a running execution fails because the domain is processing a config update
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a Step Functions state machine is created then a domain configuration update begins
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When a Step Functions state machine is created
    When a domain configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then an OpenSearch domain is created and becomes "ACTIVE" then the domain configuration update completes
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When an OpenSearch domain is created and becomes "ACTIVE"
    When the domain configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a domain configuration update begins then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When a domain configuration update begins
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then the domain configuration update completes then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When the domain configuration update completes
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an OpenSearch domain is created and becomes "ACTIVE"
    Given eid in exec_status
    When a running execution fails because the domain is processing a config update
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    When an OpenSearch domain is created and becomes "ACTIVE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called
