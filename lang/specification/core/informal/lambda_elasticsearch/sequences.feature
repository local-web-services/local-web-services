@lambdaelasticsearch @generated
Feature: LambdaElasticsearch - Action Sequences

  # Generated from FizzBee spec: lambda_elasticsearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingDomain

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "elasticsearch" "domain" configuration update begins
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "elasticsearch" "domain" configuration update completes
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "lambda" "function" is deployed
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "elasticsearch" "domain" configuration update begins
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "elasticsearch" "domain" configuration update completes
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "lambda" "function" is invoked
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then a "lambda" "function" is deployed
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then the "elasticsearch" "domain" configuration update completes
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then the "lambda" "function" is invoked
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a "lambda" "function" is deployed
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a "elasticsearch" "domain" configuration update begins
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then the "lambda" "function" is invoked
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given fid in func_status
    When the "lambda" "function" is invoked
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "elasticsearch" "domain" configuration update begins
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "elasticsearch" "domain" configuration update completes
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then a "elasticsearch" "domain" configuration update begins
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then the "elasticsearch" "domain" configuration update completes
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then a "elasticsearch" "domain" configuration update begins
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then the "elasticsearch" "domain" configuration update completes
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "elasticsearch" "domain" configuration update begins
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then a "elasticsearch" "domain" configuration update begins then the "elasticsearch" "domain" configuration update completes
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When a "elasticsearch" "domain" configuration update begins
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "elasticsearch" "domain" configuration update completes then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "elasticsearch" "domain" configuration update completes
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "lambda" "function" is deployed then the "elasticsearch" "domain" configuration update completes
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "lambda" "function" is deployed
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "elasticsearch" "domain" configuration update begins then the "lambda" "function" is invoked
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "elasticsearch" "domain" configuration update begins
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "elasticsearch" "domain" configuration update completes then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "elasticsearch" "domain" configuration update completes
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "lambda" "function" is invoked then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then a "lambda" "function" is deployed
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then a "elasticsearch" "domain" configuration update begins
    Given did not in domain_status
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then the "elasticsearch" "domain" configuration update completes then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When the "elasticsearch" "domain" configuration update completes
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: a "elasticsearch" "domain" configuration update begins then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then the "elasticsearch" "domain" configuration update completes
    Given did in domain_status
    When a "elasticsearch" "domain" configuration update begins
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a "lambda" "function" is deployed then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a "lambda" "function" is deployed
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then a "elasticsearch" "domain" configuration update begins then a "lambda" "function" is deployed
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When a "elasticsearch" "domain" configuration update begins
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then the "lambda" "function" is invoked then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When the "lambda" "function" is invoked
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then a "elasticsearch" "domain" configuration update begins
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "elasticsearch" "domain" configuration update completes then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then the "lambda" "function" is invoked
    Given did in domain_status
    When the "elasticsearch" "domain" configuration update completes
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "elasticsearch" "domain" configuration update begins then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "elasticsearch" "domain" configuration update begins
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "elasticsearch" "domain" configuration update completes then a "elasticsearch" "domain" configuration update begins
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "elasticsearch" "domain" configuration update completes
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then the "elasticsearch" "domain" configuration update completes
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then a "lambda" "function" is deployed then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When a "lambda" "function" is deployed
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then a "elasticsearch" "domain" configuration update begins
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then a "elasticsearch" "domain" configuration update begins then the "elasticsearch" "domain" configuration update completes
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When a "elasticsearch" "domain" configuration update begins
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then the "elasticsearch" "domain" configuration update completes then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When the "elasticsearch" "domain" configuration update completes
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then the "lambda" "function" is invoked then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then a "lambda" "function" is deployed then a "elasticsearch" "domain" configuration update begins
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When a "lambda" "function" is deployed
    When a "elasticsearch" "domain" configuration update begins
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then an "elasticsearch" "domain" is created and becomes "AVAILABLE" then the "elasticsearch" "domain" configuration update completes
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    When the "elasticsearch" "domain" configuration update completes
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then a "elasticsearch" "domain" configuration update begins then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When a "elasticsearch" "domain" configuration update begins
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then the "elasticsearch" "domain" configuration update completes then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When the "elasticsearch" "domain" configuration update completes
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists

  @sequence
  Scenario: the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update then the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds then an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    Given iid in inv_status
    When the "lambda" "function" fails to write because the "elasticsearch" "domain" is processing a config update
    When the "lambda" "function" indexes a "elasticsearch" "document" into the "AVAILABLE" domain and succeeds
    When an "elasticsearch" "domain" is created and becomes "AVAILABLE"
    And every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every existing document references a "elasticsearch" "domain" that exists
