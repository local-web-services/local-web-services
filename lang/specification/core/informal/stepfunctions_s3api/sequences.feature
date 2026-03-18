@stepfunctionss3api @generated
Feature: StepfunctionsS3api - Action Sequences

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 bucket is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an object to the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read because no object exists in the bucket
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Step Functions state machine is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an S3 task is configured on the state machine
    Given bid not in bucket_status
    When an S3 bucket is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an execution of the state machine is started
    Given bid not in bucket_status
    When an S3 bucket is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution writes an object to the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution fails to read because no object exists in the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an S3 bucket is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an execution of the state machine is started
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 bucket is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 bucket is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 bucket is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 bucket is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 bucket is created then an S3 task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 bucket is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 bucket is created then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 bucket is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 bucket is created then a running execution writes an object to the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 bucket is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 bucket is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 bucket is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 bucket is created then a running execution fails to read because no object exists in the bucket
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 bucket is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 task is configured on the state machine then an S3 bucket is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 task is configured on the state machine
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 task is configured on the state machine then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 task is configured on the state machine then a running execution writes an object to the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 task is configured on the state machine
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 task is configured on the state machine then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 task is configured on the state machine
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an S3 task is configured on the state machine then a running execution fails to read because no object exists in the bucket
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an S3 task is configured on the state machine
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then an S3 bucket is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then an S3 task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution writes an object to the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then an execution of the state machine is started then a running execution fails to read because no object exists in the bucket
    Given smid not in sm_status
    When a Step Functions state machine is created
    When an execution of the state machine is started
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an object to the S3 bucket and succeeds then an S3 bucket is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an object to the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an object to the S3 bucket and succeeds then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution writes an object to the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an object to the S3 bucket and succeeds then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution writes an object to the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing object from the S3 bucket and succeeds then an S3 bucket is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing object from the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing object from the S3 bucket and succeeds then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing object from the S3 bucket and succeeds then a running execution writes an object to the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution reads an existing object from the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read because no object exists in the bucket then an S3 bucket is created
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read because no object exists in the bucket
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read because no object exists in the bucket then an S3 task is configured on the state machine
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read because no object exists in the bucket
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read because no object exists in the bucket then an execution of the state machine is started
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read because no object exists in the bucket
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read because no object exists in the bucket then a running execution writes an object to the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read because no object exists in the bucket
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a Step Functions state machine is created then a running execution fails to read because no object exists in the bucket then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid not in sm_status
    When a Step Functions state machine is created
    When a running execution fails to read because no object exists in the bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Step Functions state machine is created then an S3 task is configured on the state machine
    Given bid not in bucket_status
    When an S3 bucket is created
    When a Step Functions state machine is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Step Functions state machine is created then an execution of the state machine is started
    Given bid not in bucket_status
    When an S3 bucket is created
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Step Functions state machine is created then a running execution writes an object to the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When a Step Functions state machine is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Step Functions state machine is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When a Step Functions state machine is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a Step Functions state machine is created then a running execution fails to read because no object exists in the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When a Step Functions state machine is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an S3 task is configured on the state machine then a Step Functions state machine is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When an S3 task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an S3 task is configured on the state machine then an execution of the state machine is started
    Given bid not in bucket_status
    When an S3 bucket is created
    When an S3 task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an S3 task is configured on the state machine then a running execution writes an object to the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When an S3 task is configured on the state machine
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an S3 task is configured on the state machine then a running execution reads an existing object from the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When an S3 task is configured on the state machine
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an S3 task is configured on the state machine then a running execution fails to read because no object exists in the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When an S3 task is configured on the state machine
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an execution of the state machine is started then a Step Functions state machine is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an execution of the state machine is started then an S3 task is configured on the state machine
    Given bid not in bucket_status
    When an S3 bucket is created
    When an execution of the state machine is started
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an execution of the state machine is started then a running execution writes an object to the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When an execution of the state machine is started
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an execution of the state machine is started then a running execution reads an existing object from the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When an execution of the state machine is started
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then an execution of the state machine is started then a running execution fails to read because no object exists in the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When an execution of the state machine is started
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution writes an object to the S3 bucket and succeeds then a Step Functions state machine is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution writes an object to the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution writes an object to the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution writes an object to the S3 bucket and succeeds then an execution of the state machine is started
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution writes an object to the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution writes an object to the S3 bucket and succeeds then a running execution reads an existing object from the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution writes an object to the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution reads an existing object from the S3 bucket and succeeds then a Step Functions state machine is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution reads an existing object from the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution reads an existing object from the S3 bucket and succeeds then an execution of the state machine is started
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution reads an existing object from the S3 bucket and succeeds then a running execution writes an object to the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution reads an existing object from the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution fails to read because no object exists in the bucket then a Step Functions state machine is created
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution fails to read because no object exists in the bucket
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution fails to read because no object exists in the bucket then an S3 task is configured on the state machine
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution fails to read because no object exists in the bucket
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution fails to read because no object exists in the bucket then an execution of the state machine is started
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution fails to read because no object exists in the bucket
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution fails to read because no object exists in the bucket then a running execution writes an object to the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution fails to read because no object exists in the bucket
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 bucket is created then a running execution fails to read because no object exists in the bucket then a running execution reads an existing object from the S3 bucket and succeeds
    Given bid not in bucket_status
    When an S3 bucket is created
    When a running execution fails to read because no object exists in the bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a Step Functions state machine is created then an S3 bucket is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a Step Functions state machine is created
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a Step Functions state machine is created then an execution of the state machine is started
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a Step Functions state machine is created then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a Step Functions state machine is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a Step Functions state machine is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a Step Functions state machine is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a Step Functions state machine is created then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a Step Functions state machine is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an S3 bucket is created then a Step Functions state machine is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an S3 bucket is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an S3 bucket is created then an execution of the state machine is started
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an S3 bucket is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an S3 bucket is created then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an S3 bucket is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an S3 bucket is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an S3 bucket is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an S3 bucket is created then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an S3 bucket is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an execution of the state machine is started then a Step Functions state machine is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an execution of the state machine is started then an S3 bucket is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an execution of the state machine is started
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an execution of the state machine is started then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an execution of the state machine is started
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an execution of the state machine is started then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an execution of the state machine is started
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then an execution of the state machine is started then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When an execution of the state machine is started
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution writes an object to the S3 bucket and succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution writes an object to the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution writes an object to the S3 bucket and succeeds then an S3 bucket is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution writes an object to the S3 bucket and succeeds then an execution of the state machine is started
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution writes an object to the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution writes an object to the S3 bucket and succeeds then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution writes an object to the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution reads an existing object from the S3 bucket and succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution reads an existing object from the S3 bucket and succeeds then an S3 bucket is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution reads an existing object from the S3 bucket and succeeds then an execution of the state machine is started
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution reads an existing object from the S3 bucket and succeeds then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution reads an existing object from the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution fails to read because no object exists in the bucket then a Step Functions state machine is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution fails to read because no object exists in the bucket
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution fails to read because no object exists in the bucket then an S3 bucket is created
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution fails to read because no object exists in the bucket
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution fails to read because no object exists in the bucket then an execution of the state machine is started
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution fails to read because no object exists in the bucket
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution fails to read because no object exists in the bucket then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution fails to read because no object exists in the bucket
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an S3 task is configured on the state machine then a running execution fails to read because no object exists in the bucket then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an S3 task is configured on the state machine
    When a running execution fails to read because no object exists in the bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then an S3 bucket is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then an S3 task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a Step Functions state machine is created then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an execution of the state machine is started
    When a Step Functions state machine is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 bucket is created then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 bucket is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 bucket is created then an S3 task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 bucket is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 bucket is created then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 bucket is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 bucket is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 bucket is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 bucket is created then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 bucket is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 task is configured on the state machine then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 task is configured on the state machine then an S3 bucket is created
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 task is configured on the state machine
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 task is configured on the state machine then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 task is configured on the state machine
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 task is configured on the state machine then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 task is configured on the state machine
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then an S3 task is configured on the state machine then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an execution of the state machine is started
    When an S3 task is configured on the state machine
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution writes an object to the S3 bucket and succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution writes an object to the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution writes an object to the S3 bucket and succeeds then an S3 bucket is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution writes an object to the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution writes an object to the S3 bucket and succeeds then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution writes an object to the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing object from the S3 bucket and succeeds then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing object from the S3 bucket and succeeds then an S3 bucket is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing object from the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing object from the S3 bucket and succeeds then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution reads an existing object from the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read because no object exists in the bucket then a Step Functions state machine is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read because no object exists in the bucket
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read because no object exists in the bucket then an S3 bucket is created
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read because no object exists in the bucket
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read because no object exists in the bucket then an S3 task is configured on the state machine
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read because no object exists in the bucket
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read because no object exists in the bucket then a running execution writes an object to the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read because no object exists in the bucket
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: an execution of the state machine is started then a running execution fails to read because no object exists in the bucket then a running execution reads an existing object from the S3 bucket and succeeds
    Given smid in sm_status
    When an execution of the state machine is started
    When a running execution fails to read because no object exists in the bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a Step Functions state machine is created then an S3 bucket is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a Step Functions state machine is created
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a Step Functions state machine is created then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a Step Functions state machine is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a Step Functions state machine is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a Step Functions state machine is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a Step Functions state machine is created then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a Step Functions state machine is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 bucket is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 bucket is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 bucket is created then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 bucket is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 bucket is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 bucket is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 bucket is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 bucket is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 bucket is created then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 bucket is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 task is configured on the state machine then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 task is configured on the state machine then an S3 bucket is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 task is configured on the state machine then an execution of the state machine is started
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 task is configured on the state machine then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an S3 task is configured on the state machine then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an execution of the state machine is started then an S3 bucket is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an execution of the state machine is started
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an execution of the state machine is started then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an execution of the state machine is started
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an execution of the state machine is started then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an execution of the state machine is started
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then an execution of the state machine is started then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When an execution of the state machine is started
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution reads an existing object from the S3 bucket and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution reads an existing object from the S3 bucket and succeeds then an S3 bucket is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution reads an existing object from the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution reads an existing object from the S3 bucket and succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution reads an existing object from the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket then an S3 bucket is created
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket then an execution of the state machine is started
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution writes an object to the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a Step Functions state machine is created then an S3 bucket is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a Step Functions state machine is created
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a Step Functions state machine is created then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a Step Functions state machine is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a Step Functions state machine is created then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a Step Functions state machine is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a Step Functions state machine is created then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a Step Functions state machine is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 bucket is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 bucket is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 bucket is created then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 bucket is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 bucket is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 bucket is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 bucket is created then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 bucket is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 bucket is created then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 bucket is created
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 task is configured on the state machine then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 task is configured on the state machine then an S3 bucket is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 task is configured on the state machine then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 task is configured on the state machine then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an S3 task is configured on the state machine then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an execution of the state machine is started then an S3 bucket is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an execution of the state machine is started
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an execution of the state machine is started then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an execution of the state machine is started
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an execution of the state machine is started then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an execution of the state machine is started
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then an execution of the state machine is started then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an execution of the state machine is started
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution writes an object to the S3 bucket and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution writes an object to the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution writes an object to the S3 bucket and succeeds then an S3 bucket is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution writes an object to the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution writes an object to the S3 bucket and succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution writes an object to the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution writes an object to the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket then an S3 bucket is created
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket then an execution of the state machine is started
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution reads an existing object from the S3 bucket and succeeds then a running execution fails to read because no object exists in the bucket then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution fails to read because no object exists in the bucket
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a Step Functions state machine is created then an S3 bucket is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a Step Functions state machine is created
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a Step Functions state machine is created then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a Step Functions state machine is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a Step Functions state machine is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a Step Functions state machine is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a Step Functions state machine is created then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a Step Functions state machine is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a Step Functions state machine is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a Step Functions state machine is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 bucket is created then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 bucket is created
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 bucket is created then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 bucket is created
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 bucket is created then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 bucket is created
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 bucket is created then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 bucket is created
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 bucket is created then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 bucket is created
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 task is configured on the state machine then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 task is configured on the state machine
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 task is configured on the state machine then an S3 bucket is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 task is configured on the state machine
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 task is configured on the state machine then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 task is configured on the state machine
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 task is configured on the state machine then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 task is configured on the state machine
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an S3 task is configured on the state machine then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an S3 task is configured on the state machine
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an execution of the state machine is started then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an execution of the state machine is started
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an execution of the state machine is started then an S3 bucket is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an execution of the state machine is started
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an execution of the state machine is started then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an execution of the state machine is started
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an execution of the state machine is started then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an execution of the state machine is started
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then an execution of the state machine is started then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When an execution of the state machine is started
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution writes an object to the S3 bucket and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution writes an object to the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution writes an object to the S3 bucket and succeeds then an S3 bucket is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution writes an object to the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution writes an object to the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution writes an object to the S3 bucket and succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution writes an object to the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution writes an object to the S3 bucket and succeeds then a running execution reads an existing object from the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution writes an object to the S3 bucket and succeeds
    When a running execution reads an existing object from the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution reads an existing object from the S3 bucket and succeeds then a Step Functions state machine is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a Step Functions state machine is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution reads an existing object from the S3 bucket and succeeds then an S3 bucket is created
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 bucket is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution reads an existing object from the S3 bucket and succeeds then an S3 task is configured on the state machine
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution reads an existing object from the S3 bucket and succeeds then an execution of the state machine is started
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    When an execution of the state machine is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @exhaustive @sequence
  Scenario: a running execution fails to read because no object exists in the bucket then a running execution reads an existing object from the S3 bucket and succeeds then a running execution writes an object to the S3 bucket and succeeds
    Given eid in exec_status
    When a running execution fails to read because no object exists in the bucket
    When a running execution reads an existing object from the S3 bucket and succeeds
    When a running execution writes an object to the S3 bucket and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket
