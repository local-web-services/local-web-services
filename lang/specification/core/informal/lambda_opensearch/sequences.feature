@lambdaopensearch @generated
Feature: LambdaOpensearch - Action Sequences

  # Generated from FizzBee spec: lambda_opensearch.fizz
  # Safety invariants: InvocationRequiresActiveFunction, DocumentRequiresExistingIndex, IndexRequiresActiveDomain

  Background:
    Given the system is initialized

  @sequence
  Scenario: a Lambda function is deployed then an OpenSearch domain is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: a Lambda function is deployed then an index is created in the OpenSearch domain
    Given fid not in func_status
    Given a Lambda function has been deployed
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function indexes a document into the OpenSearch index during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then a Lambda function is deployed
    Given did not in domain_status
    Given an OpenSearch domain has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then an index is created in the OpenSearch domain
    Given did not in domain_status
    Given an OpenSearch domain has been created
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then the Lambda function is invoked
    Given did not in domain_status
    Given an OpenSearch domain has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then the Lambda function indexes a document into the OpenSearch index during invocation
    Given did not in domain_status
    Given an OpenSearch domain has been created
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then the Lambda invocation completes successfully
    Given did not in domain_status
    Given an OpenSearch domain has been created
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then the Lambda invocation fails
    Given did not in domain_status
    Given an OpenSearch domain has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then a Lambda function is deployed
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then an OpenSearch domain is created
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda function is invoked
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda function indexes a document into the OpenSearch index during invocation
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda invocation completes successfully
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda invocation fails
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then an OpenSearch domain is created
    Given fid in func_status
    Given the Lambda function has been invoked
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then an index is created in the OpenSearch domain
    Given fid in func_status
    Given the Lambda function has been invoked
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function indexes a document into the OpenSearch index during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails
    Given fid in func_status
    Given the Lambda function has been invoked
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then an OpenSearch domain is created
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then an index is created in the OpenSearch domain
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then an OpenSearch domain is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then an index is created in the OpenSearch domain
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then an OpenSearch domain is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then an index is created in the OpenSearch domain
    Given iid in inv_status
    Given the Lambda invocation has failed
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then the Lambda function indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: a Lambda function is deployed then an OpenSearch domain is created then an index is created in the OpenSearch domain
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an OpenSearch domain has been created
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: a Lambda function is deployed then an index is created in the OpenSearch domain then the Lambda function is invoked
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given an index has been created in the OpenSearch domain
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function is invoked then the Lambda function indexes a document into the OpenSearch index during invocation
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has been invoked
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: a Lambda function is deployed then the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation completes successfully
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation completes successfully then the Lambda invocation fails
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has completed successfully
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: a Lambda function is deployed then the Lambda invocation fails then an OpenSearch domain is created
    Given fid not in func_status
    Given a Lambda function has been deployed
    Given the Lambda invocation has failed
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then a Lambda function is deployed then the Lambda function is invoked
    Given did not in domain_status
    Given an OpenSearch domain has been created
    Given a Lambda function has been deployed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then an index is created in the OpenSearch domain then the Lambda function indexes a document into the OpenSearch index during invocation
    Given did not in domain_status
    Given an OpenSearch domain has been created
    Given an index has been created in the OpenSearch domain
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then the Lambda function is invoked then the Lambda invocation completes successfully
    Given did not in domain_status
    Given an OpenSearch domain has been created
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation fails
    Given did not in domain_status
    Given an OpenSearch domain has been created
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then the Lambda invocation completes successfully then a Lambda function is deployed
    Given did not in domain_status
    Given an OpenSearch domain has been created
    Given the Lambda invocation has completed successfully
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an OpenSearch domain is created then the Lambda invocation fails then an index is created in the OpenSearch domain
    Given did not in domain_status
    Given an OpenSearch domain has been created
    Given the Lambda invocation has failed
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then a Lambda function is deployed then the Lambda function indexes a document into the OpenSearch index during invocation
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    Given a Lambda function has been deployed
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then an OpenSearch domain is created then the Lambda invocation completes successfully
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    Given an OpenSearch domain has been created
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda function is invoked then the Lambda invocation fails
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    Given the Lambda function has been invoked
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda function indexes a document into the OpenSearch index during invocation then a Lambda function is deployed
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda invocation completes successfully then an OpenSearch domain is created
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    Given the Lambda invocation has completed successfully
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: an index is created in the OpenSearch domain then the Lambda invocation fails then the Lambda function is invoked
    Given did in domain_status
    Given an index has been created in the OpenSearch domain
    Given the Lambda invocation has failed
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then a Lambda function is deployed then the Lambda invocation completes successfully
    Given fid in func_status
    Given the Lambda function has been invoked
    Given a Lambda function has been deployed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then an OpenSearch domain is created then the Lambda invocation fails
    Given fid in func_status
    Given the Lambda function has been invoked
    Given an OpenSearch domain has been created
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then an index is created in the OpenSearch domain then a Lambda function is deployed
    Given fid in func_status
    Given the Lambda function has been invoked
    Given an index has been created in the OpenSearch domain
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then the Lambda function indexes a document into the OpenSearch index during invocation then an OpenSearch domain is created
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation completes successfully then an index is created in the OpenSearch domain
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda invocation has completed successfully
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function is invoked then the Lambda invocation fails then the Lambda function indexes a document into the OpenSearch index during invocation
    Given fid in func_status
    Given the Lambda function has been invoked
    Given the Lambda invocation has failed
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then a Lambda function is deployed then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    Given a Lambda function has been deployed
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then an OpenSearch domain is created then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    Given an OpenSearch domain has been created
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then an index is created in the OpenSearch domain then an OpenSearch domain is created
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    Given an index has been created in the OpenSearch domain
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda function is invoked then an index is created in the OpenSearch domain
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    Given the Lambda function has been invoked
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation completes successfully then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    Given the Lambda invocation has completed successfully
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation fails then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    Given the Lambda invocation has failed
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then a Lambda function is deployed then an OpenSearch domain is created
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given a Lambda function has been deployed
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then an OpenSearch domain is created then an index is created in the OpenSearch domain
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an OpenSearch domain has been created
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then an index is created in the OpenSearch domain then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given an index has been created in the OpenSearch domain
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function is invoked then the Lambda function indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda function has been invoked
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda function indexes a document into the OpenSearch index during invocation then the Lambda invocation fails
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When the Lambda invocation fails
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation completes successfully then the Lambda invocation fails then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has completed successfully
    Given the Lambda invocation has failed
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then a Lambda function is deployed then an index is created in the OpenSearch domain
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given a Lambda function has been deployed
    When an index is created in the OpenSearch domain
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then an OpenSearch domain is created then the Lambda function is invoked
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an OpenSearch domain has been created
    When the Lambda function is invoked
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then an index is created in the OpenSearch domain then the Lambda function indexes a document into the OpenSearch index during invocation
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given an index has been created in the OpenSearch domain
    When the Lambda function indexes a document into the OpenSearch index during invocation
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then the Lambda function is invoked then the Lambda invocation completes successfully
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda function has been invoked
    When the Lambda invocation completes successfully
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then the Lambda function indexes a document into the OpenSearch index during invocation then a Lambda function is deployed
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda function has indexed a document into the OpenSearch index during invocation
    When a Lambda function is deployed
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain

  @sequence
  Scenario: the Lambda invocation fails then the Lambda invocation completes successfully then an OpenSearch domain is created
    Given iid in inv_status
    Given the Lambda invocation has failed
    Given the Lambda invocation has completed successfully
    When an OpenSearch domain is created
    Then every "IN_PROGRESS" invocation references an "ACTIVE" Lambda function
    And every indexed document belongs to an existing index
    And every existing index belongs to an "ACTIVE" domain
