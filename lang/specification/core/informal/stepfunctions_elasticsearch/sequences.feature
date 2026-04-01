@stepfunctionselasticsearch @generated
Feature: StepfunctionsElasticsearch - Action Sequences

  # Generated from FizzBee spec: stepfunctions_elasticsearch.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, SuccessfulExecutionCalledADomain

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "elasticsearch" "domain" configuration update begins
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then the "elasticsearch" "domain" configuration update completes
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "elasticsearch" "domain" configuration update completes
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
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "step functions" "state machine" is created
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "elasticsearch" "domain" configuration update begins
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "elasticsearch" "domain" configuration update completes
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "elasticsearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then a "step functions" "state machine" is created
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then the "elasticsearch" "domain" configuration update completes
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When the "elasticsearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a "step functions" "state machine" is created
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a "elasticsearch" "domain" configuration update begins
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
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
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "elasticsearch" "domain" configuration update begins
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "elasticsearch" "domain" configuration update completes
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "elasticsearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then a "elasticsearch" "domain" configuration update begins
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then the "elasticsearch" "domain" configuration update completes
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When the "elasticsearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then a "elasticsearch" "domain" configuration update begins
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then the "elasticsearch" "domain" configuration update completes
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When the "elasticsearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "elasticsearch" "domain" configuration update begins
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a "elasticsearch" "domain" configuration update begins then the "elasticsearch" "domain" configuration update completes
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "elasticsearch" "domain" configuration update begins
    When the "elasticsearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then the "elasticsearch" "domain" configuration update completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When the "elasticsearch" "domain" configuration update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "step functions" "state machine" is created then the "elasticsearch" "domain" configuration update completes
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "step functions" "state machine" is created
    When the "elasticsearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "elasticsearch" "domain" configuration update begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "elasticsearch" "domain" configuration update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "elasticsearch" "domain" configuration update completes then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "elasticsearch" "domain" configuration update completes
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then a "step functions" "state machine" is created
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then a "elasticsearch" "domain" configuration update begins
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then the "elasticsearch" "domain" configuration update completes then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When the "elasticsearch" "domain" configuration update completes
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then the "elasticsearch" "domain" configuration update completes
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When the "elasticsearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a "step functions" "state machine" is created then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a "elasticsearch" "domain" configuration update begins then a "step functions" "state machine" is created
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a "elasticsearch" "domain" configuration update begins
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then an "step functions" "execution" of the "step functions" "state machine" is started then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then a "elasticsearch" "domain" configuration update begins
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then an "step functions" "execution" of the "step functions" "state machine" is started
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "elasticsearch" "domain" configuration update begins then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "elasticsearch" "domain" configuration update begins
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then the "elasticsearch" "domain" configuration update completes then a "elasticsearch" "domain" configuration update begins
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When the "elasticsearch" "domain" configuration update completes
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then the "elasticsearch" "domain" configuration update completes
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When the "elasticsearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then a "step functions" "state machine" is created then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When a "step functions" "state machine" is created
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "elasticsearch" "domain" configuration update begins
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then a "elasticsearch" "domain" configuration update begins then the "elasticsearch" "domain" configuration update completes
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When a "elasticsearch" "domain" configuration update begins
    When the "elasticsearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then the "elasticsearch" "domain" configuration update completes then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When the "elasticsearch" "domain" configuration update completes
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then a "step functions" "state machine" is created then a "elasticsearch" "domain" configuration update begins
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When a "step functions" "state machine" is created
    When a "elasticsearch" "domain" configuration update begins
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "elasticsearch" "domain" configuration update completes
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "elasticsearch" "domain" configuration update completes
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then a "elasticsearch" "domain" configuration update begins then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When a "elasticsearch" "domain" configuration update begins
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then the "elasticsearch" "domain" configuration update completes then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When the "elasticsearch" "domain" configuration update completes
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called

  @sequence
  Scenario: a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update then a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given eid in exec_status
    When a running "step functions" "execution" fails because the "elasticsearch" "domain" is processing a config update
    When a running "step functions" "execution" calls an "AVAILABLE" Elasticsearch domain and the task succeeds
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every succeeded execution recorded which domain it called
