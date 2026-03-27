@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - Action Sequences

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a domain configuration update begins
    Given fid not in func_status
    Given a Lambda function has been deployed
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the domain configuration update completes
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the domain is processing a config update
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then a Lambda function is deployed
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then a domain configuration update begins
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the domain configuration update completes
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function is invoked
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function fails to write because the domain is processing a config update
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a Lambda function is deployed
    Given did in domain_status
    Given a domain configuration update has begun
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given did in domain_status
    Given a domain configuration update has begun
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the domain configuration update completes
    Given did in domain_status
    Given a domain configuration update has begun
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function is invoked
    Given did in domain_status
    Given a domain configuration update has begun
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    Given a domain configuration update has begun
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function fails to write because the domain is processing a config update
    Given did in domain_status
    Given a domain configuration update has begun
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a Lambda function is deployed
    Given did in domain_status
    Given the domain configuration update has completed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given did in domain_status
    Given the domain configuration update has completed
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a domain configuration update begins
    Given did in domain_status
    Given the domain configuration update has completed
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function is invoked
    Given did in domain_status
    Given the domain configuration update has completed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    Given the domain configuration update has completed
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function fails to write because the domain is processing a config update
    Given did in domain_status
    Given the domain configuration update has completed
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given fid in func_status
    Given the Lambda function has been invoked
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a domain configuration update begins
    Given fid in func_status
    Given the Lambda function has been invoked
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the domain configuration update completes
    Given fid in func_status
    Given the Lambda function has been invoked
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the domain is processing a config update
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a domain configuration update begins
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the domain configuration update completes
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the Lambda function fails to write because the domain is processing a config update
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then a domain configuration update begins
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the domain configuration update completes
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an Elasticsearch domain is created and becomes "AVAILABLE" then a domain configuration update begins
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a domain configuration update begins then the domain configuration update completes
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given a domain configuration update has begun
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the domain configuration update completes then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the domain configuration update has completed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the Lambda function fails to write because the domain is processing a config update
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the domain is processing a config update then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has failed to write because the domain is processing a config update
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then a Lambda function is deployed then the domain configuration update completes
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    Given a Lambda function has been deployed
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then a domain configuration update begins then the Lambda function is invoked
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    Given a domain configuration update has begun
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the domain configuration update completes then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    Given the domain configuration update has completed
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function is invoked then the Lambda function fails to write because the domain is processing a config update
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    Given the Lambda function has been invoked
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a Lambda function is deployed
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function fails to write because the domain is processing a config update then a domain configuration update begins
    Given did not in domain_status
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    Given the Lambda function has failed to write because the domain is processing a config update
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a Lambda function is deployed then the Lambda function is invoked
    Given did in domain_status
    Given a domain configuration update has begun
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    Given a domain configuration update has begun
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the domain configuration update completes then the Lambda function fails to write because the domain is processing a config update
    Given did in domain_status
    Given a domain configuration update has begun
    Given the domain configuration update has completed
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function is invoked then a Lambda function is deployed
    Given did in domain_status
    Given a domain configuration update has begun
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given did in domain_status
    Given a domain configuration update has begun
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function fails to write because the domain is processing a config update then the domain configuration update completes
    Given did in domain_status
    Given a domain configuration update has begun
    Given the Lambda function has failed to write because the domain is processing a config update
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a Lambda function is deployed then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    Given the domain configuration update has completed
    Given a Lambda function has been deployed
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function fails to write because the domain is processing a config update
    Given did in domain_status
    Given the domain configuration update has completed
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a domain configuration update begins then a Lambda function is deployed
    Given did in domain_status
    Given the domain configuration update has completed
    Given a domain configuration update has begun
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function is invoked then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given did in domain_status
    Given the domain configuration update has completed
    Given the Lambda function has been invoked
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a domain configuration update begins
    Given did in domain_status
    Given the domain configuration update has completed
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function fails to write because the domain is processing a config update then the Lambda function is invoked
    Given did in domain_status
    Given the domain configuration update has completed
    Given the Lambda function has failed to write because the domain is processing a config update
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to write because the domain is processing a config update
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an Elasticsearch domain is created and becomes "AVAILABLE" then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a domain configuration update begins then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a domain configuration update has begun
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the domain configuration update completes then a domain configuration update begins
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the domain configuration update has completed
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the domain configuration update completes
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the domain is processing a config update then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has failed to write because the domain is processing a config update
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a Lambda function is deployed then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    Given a Lambda function has been deployed
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then an Elasticsearch domain is created and becomes "AVAILABLE" then a domain configuration update begins
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a domain configuration update begins then the domain configuration update completes
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    Given a domain configuration update has begun
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the domain configuration update completes then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    Given the domain configuration update has completed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the Lambda function is invoked then the Lambda function fails to write because the domain is processing a config update
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    Given the Lambda function has been invoked
    When the Lambda function fails to write because the domain is processing a config update
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the Lambda function fails to write because the domain is processing a config update then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    Given the Lambda function has failed to write because the domain is processing a config update
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then a Lambda function is deployed then a domain configuration update begins
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    Given a Lambda function has been deployed
    When a domain configuration update begins
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then an Elasticsearch domain is created and becomes "AVAILABLE" then the domain configuration update completes
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    Given an Elasticsearch domain has been created and become "AVAILABLE"
    When the domain configuration update completes
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then a domain configuration update begins then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    Given a domain configuration update has begun
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the domain configuration update completes then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    Given the domain configuration update has completed
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given iid in inv_status
    Given the Lambda function has failed to write because the domain is processing a config update
    Given the Lambda function has indexed a document into the "AVAILABLE" domain and succeeded
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists
