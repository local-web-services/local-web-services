@stepfunctionsopensearch @generated
Feature: StepfunctionsOpensearch - Action Sequences

  # Generated from FizzBee spec: stepfunctions_opensearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an OpenSearch domain is created and becomes "ACTIVE"
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a domain configuration update begins
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the domain configuration update completes
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the domain is processing a config update
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a Step Functions state machine is created
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a domain configuration update begins
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then the domain configuration update completes
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then an execution of the state machine is started
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a running execution fails because the domain is processing a config update
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a Step Functions state machine is created
    Given did in domain_status
    Given a domain configuration update has begun
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an OpenSearch domain is created and becomes "ACTIVE"
    Given did in domain_status
    Given a domain configuration update has begun
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the domain configuration update completes
    Given did in domain_status
    Given a domain configuration update has begun
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an execution of the state machine is started
    Given did in domain_status
    Given a domain configuration update has begun
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    Given a domain configuration update has begun
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a running execution fails because the domain is processing a config update
    Given did in domain_status
    Given a domain configuration update has begun
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a Step Functions state machine is created
    Given did in domain_status
    Given the domain configuration update has completed
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an OpenSearch domain is created and becomes "ACTIVE"
    Given did in domain_status
    Given the domain configuration update has completed
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a domain configuration update begins
    Given did in domain_status
    Given the domain configuration update has completed
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an execution of the state machine is started
    Given did in domain_status
    Given the domain configuration update has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    Given the domain configuration update has completed
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a running execution fails because the domain is processing a config update
    Given did in domain_status
    Given the domain configuration update has completed
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an OpenSearch domain is created and becomes "ACTIVE"
    Given smid in sm_status
    Given an execution of the state machine has been started
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a domain configuration update begins
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the domain configuration update completes
    Given smid in sm_status
    Given an execution of the state machine has been started
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the domain is processing a config update
    Given smid in sm_status
    Given an execution of the state machine has been started
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an OpenSearch domain is created and becomes "ACTIVE"
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a domain configuration update begins
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then the domain configuration update completes
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a running execution fails because the domain is processing a config update
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then an OpenSearch domain is created and becomes "ACTIVE"
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a domain configuration update begins
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then the domain configuration update completes
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an OpenSearch domain is created and becomes "ACTIVE" then a domain configuration update begins
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an OpenSearch domain has been created and is "ACTIVE"
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a domain configuration update begins then the domain configuration update completes
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a domain configuration update has begun
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then the domain configuration update completes then an execution of the state machine is started
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given the domain configuration update has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given an execution of the state machine has been started
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a running execution fails because the domain is processing a config update
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails because the domain is processing a config update then an OpenSearch domain is created and becomes "ACTIVE"
    Given smid not in sm_status
    Given a Step Functions state machine has been created
    Given a running execution has failed because the domain is processing a config update
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a Step Functions state machine is created then the domain configuration update completes
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    Given a Step Functions state machine has been created
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a domain configuration update begins then an execution of the state machine is started
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    Given a domain configuration update has begun
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then the domain configuration update completes then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    Given the domain configuration update has completed
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then an execution of the state machine is started then a running execution fails because the domain is processing a config update
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    Given an execution of the state machine has been started
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a Step Functions state machine is created
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an OpenSearch domain is created and becomes "ACTIVE" then a running execution fails because the domain is processing a config update then a domain configuration update begins
    Given did not in domain_status
    Given an OpenSearch domain has been created and is "ACTIVE"
    Given a running execution has failed because the domain is processing a config update
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a Step Functions state machine is created then an execution of the state machine is started
    Given did in domain_status
    Given a domain configuration update has begun
    Given a Step Functions state machine has been created
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an OpenSearch domain is created and becomes "ACTIVE" then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    Given a domain configuration update has begun
    Given an OpenSearch domain has been created and is "ACTIVE"
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the domain configuration update completes then a running execution fails because the domain is processing a config update
    Given did in domain_status
    Given a domain configuration update has begun
    Given the domain configuration update has completed
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an execution of the state machine is started then a Step Functions state machine is created
    Given did in domain_status
    Given a domain configuration update has begun
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an OpenSearch domain is created and becomes "ACTIVE"
    Given did in domain_status
    Given a domain configuration update has begun
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a running execution fails because the domain is processing a config update then the domain configuration update completes
    Given did in domain_status
    Given a domain configuration update has begun
    Given a running execution has failed because the domain is processing a config update
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a Step Functions state machine is created then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given did in domain_status
    Given the domain configuration update has completed
    Given a Step Functions state machine has been created
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an OpenSearch domain is created and becomes "ACTIVE" then a running execution fails because the domain is processing a config update
    Given did in domain_status
    Given the domain configuration update has completed
    Given an OpenSearch domain has been created and is "ACTIVE"
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a domain configuration update begins then a Step Functions state machine is created
    Given did in domain_status
    Given the domain configuration update has completed
    Given a domain configuration update has begun
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an execution of the state machine is started then an OpenSearch domain is created and becomes "ACTIVE"
    Given did in domain_status
    Given the domain configuration update has completed
    Given an execution of the state machine has been started
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a domain configuration update begins
    Given did in domain_status
    Given the domain configuration update has completed
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a running execution fails because the domain is processing a config update then an execution of the state machine is started
    Given did in domain_status
    Given the domain configuration update has completed
    Given a running execution has failed because the domain is processing a config update
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails because the domain is processing a config update
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a Step Functions state machine has been created
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an OpenSearch domain is created and becomes "ACTIVE" then a Step Functions state machine is created
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given an OpenSearch domain has been created and is "ACTIVE"
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a domain configuration update begins then an OpenSearch domain is created and becomes "ACTIVE"
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a domain configuration update has begun
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then the domain configuration update completes then a domain configuration update begins
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given the domain configuration update has completed
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then the domain configuration update completes
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails because the domain is processing a config update then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given smid in sm_status
    Given an execution of the state machine has been started
    Given a running execution has failed because the domain is processing a config update
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a Step Functions state machine is created then an OpenSearch domain is created and becomes "ACTIVE"
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    Given a Step Functions state machine has been created
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an OpenSearch domain is created and becomes "ACTIVE" then a domain configuration update begins
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    Given an OpenSearch domain has been created and is "ACTIVE"
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a domain configuration update begins then the domain configuration update completes
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    Given a domain configuration update has begun
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then the domain configuration update completes then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    Given the domain configuration update has completed
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an execution of the state machine is started then a running execution fails because the domain is processing a config update
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    Given an execution of the state machine has been started
    When a running execution fails because the domain is processing a config update
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then a running execution fails because the domain is processing a config update then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    Given a running execution has failed because the domain is processing a config update
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a Step Functions state machine is created then a domain configuration update begins
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    Given a Step Functions state machine has been created
    When a domain configuration update begins
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then an OpenSearch domain is created and becomes "ACTIVE" then the domain configuration update completes
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    Given an OpenSearch domain has been created and is "ACTIVE"
    When the domain configuration update completes
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a domain configuration update begins then an execution of the state machine is started
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    Given a domain configuration update has begun
    When an execution of the state machine is started
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then the domain configuration update completes then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    Given the domain configuration update has completed
    When a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    Given an execution of the state machine has been started
    When a Step Functions state machine is created
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @exhaustive @sequence
  Scenario: a running execution fails because the domain is processing a config update then a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds then an OpenSearch domain is created and becomes "ACTIVE"
    Given eid in exec_status
    Given a running execution has failed because the domain is processing a config update
    Given a running execution has called an "ACTIVE" OpenSearch domain and the task succeeded
    When an OpenSearch domain is created and becomes "ACTIVE"
    Then every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called
