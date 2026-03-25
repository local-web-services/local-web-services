@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - Action Sequences

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given fid not in func_status
    When a Lambda function is deployed
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a domain configuration update begins
    Given fid not in func_status
    When a Lambda function is deployed
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the domain configuration update completes
    Given fid not in func_status
    When a Lambda function is deployed
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the domain is processing a config update
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then a Lambda function is deployed
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then a domain configuration update begins
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the domain configuration update completes
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function is invoked
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function fails to write because the domain is processing a config update
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a Lambda function is deployed
    Given did in domain_status
    When a domain configuration update begins
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given did in domain_status
    When a domain configuration update begins
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the domain configuration update completes
    Given did in domain_status
    When a domain configuration update begins
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function is invoked
    Given did in domain_status
    When a domain configuration update begins
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    When a domain configuration update begins
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function fails to write because the domain is processing a config update
    Given did in domain_status
    When a domain configuration update begins
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a Lambda function is deployed
    Given did in domain_status
    When the domain configuration update completes
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given did in domain_status
    When the domain configuration update completes
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a domain configuration update begins
    Given did in domain_status
    When the domain configuration update completes
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function is invoked
    Given did in domain_status
    When the domain configuration update completes
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    When the domain configuration update completes
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function fails to write because the domain is processing a config update
    Given did in domain_status
    When the domain configuration update completes
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given fid in func_status
    When the Lambda function is invoked
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a domain configuration update begins
    Given fid in func_status
    When the Lambda function is invoked
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the domain configuration update completes
    Given fid in func_status
    When the Lambda function is invoked
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the domain is processing a config update
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a domain configuration update begins
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the domain configuration update completes
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the Lambda function fails to write because the domain is processing a config update
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then a domain configuration update begins
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the domain configuration update completes
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then an Elasticsearch domain is created and becomes "AVAILABLE" then a domain configuration update begins
    Given fid not in func_status
    When a Lambda function is deployed
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then a domain configuration update begins then the domain configuration update completes
    Given fid not in func_status
    When a Lambda function is deployed
    When a domain configuration update begins
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the domain configuration update completes then the Lambda function is invoked
    Given fid not in func_status
    When a Lambda function is deployed
    When the domain configuration update completes
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function is invoked
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the Lambda function fails to write because the domain is processing a config update
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a Lambda function is deployed then the Lambda function fails to write because the domain is processing a config update then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given fid not in func_status
    When a Lambda function is deployed
    When the Lambda function fails to write because the domain is processing a config update
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then a Lambda function is deployed then the domain configuration update completes
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When a Lambda function is deployed
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then a domain configuration update begins then the Lambda function is invoked
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When a domain configuration update begins
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the domain configuration update completes then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When the domain configuration update completes
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function is invoked then the Lambda function fails to write because the domain is processing a config update
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When the Lambda function is invoked
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a Lambda function is deployed
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function fails to write because the domain is processing a config update then a domain configuration update begins
    Given did not in domain_status
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When the Lambda function fails to write because the domain is processing a config update
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then a Lambda function is deployed then the Lambda function is invoked
    Given did in domain_status
    When a domain configuration update begins
    When a Lambda function is deployed
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    When a domain configuration update begins
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the domain configuration update completes then the Lambda function fails to write because the domain is processing a config update
    Given did in domain_status
    When a domain configuration update begins
    When the domain configuration update completes
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function is invoked then a Lambda function is deployed
    Given did in domain_status
    When a domain configuration update begins
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given did in domain_status
    When a domain configuration update begins
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: a domain configuration update begins then the Lambda function fails to write because the domain is processing a config update then the domain configuration update completes
    Given did in domain_status
    When a domain configuration update begins
    When the Lambda function fails to write because the domain is processing a config update
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a Lambda function is deployed then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    When the domain configuration update completes
    When a Lambda function is deployed
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then an Elasticsearch domain is created and becomes "AVAILABLE" then the Lambda function fails to write because the domain is processing a config update
    Given did in domain_status
    When the domain configuration update completes
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then a domain configuration update begins then a Lambda function is deployed
    Given did in domain_status
    When the domain configuration update completes
    When a domain configuration update begins
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function is invoked then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given did in domain_status
    When the domain configuration update completes
    When the Lambda function is invoked
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a domain configuration update begins
    Given did in domain_status
    When the domain configuration update completes
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the domain configuration update completes then the Lambda function fails to write because the domain is processing a config update then the Lambda function is invoked
    Given did in domain_status
    When the domain configuration update completes
    When the Lambda function fails to write because the domain is processing a config update
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda function fails to write because the domain is processing a config update
    Given fid in func_status
    When the Lambda function is invoked
    When a Lambda function is deployed
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then an Elasticsearch domain is created and becomes "AVAILABLE" then a Lambda function is deployed
    Given fid in func_status
    When the Lambda function is invoked
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then a domain configuration update begins then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given fid in func_status
    When the Lambda function is invoked
    When a domain configuration update begins
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the domain configuration update completes then a domain configuration update begins
    Given fid in func_status
    When the Lambda function is invoked
    When the domain configuration update completes
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the domain configuration update completes
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function is invoked then the Lambda function fails to write because the domain is processing a config update then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given fid in func_status
    When the Lambda function is invoked
    When the Lambda function fails to write because the domain is processing a config update
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a Lambda function is deployed then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When a Lambda function is deployed
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then an Elasticsearch domain is created and becomes "AVAILABLE" then a domain configuration update begins
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then a domain configuration update begins then the domain configuration update completes
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When a domain configuration update begins
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the domain configuration update completes then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When the domain configuration update completes
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the Lambda function is invoked then the Lambda function fails to write because the domain is processing a config update
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When the Lambda function is invoked
    When the Lambda function fails to write because the domain is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then the Lambda function fails to write because the domain is processing a config update then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When the Lambda function fails to write because the domain is processing a config update
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then a Lambda function is deployed then a domain configuration update begins
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When a Lambda function is deployed
    When a domain configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then an Elasticsearch domain is created and becomes "AVAILABLE" then the domain configuration update completes
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    When the domain configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then a domain configuration update begins then the Lambda function is invoked
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When a domain configuration update begins
    When the Lambda function is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the domain configuration update completes then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When the domain configuration update completes
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the Lambda function is invoked then a Lambda function is deployed
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When the Lambda function is invoked
    When a Lambda function is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists

  @exhaustive @sequence
  Scenario: the Lambda function fails to write because the domain is processing a config update then the Lambda function indexes a document into the "AVAILABLE" domain and succeeds then an Elasticsearch domain is created and becomes "AVAILABLE"
    Given iid in inv_status
    When the Lambda function fails to write because the domain is processing a config update
    When the Lambda function indexes a document into the "AVAILABLE" domain and succeeds
    When an Elasticsearch domain is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a domain that exists
