@stepfunctionss3api @generated
Feature: StepfunctionsS3api - Action Sequences

  # Generated from FizzBee spec: stepfunctions_s3api.fizz
  # Safety invariants: ExecutionRequiresActiveStateMachine, ObjectRequiresActiveBucket

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "step functions" "state machine" is created then a "s3" "bucket" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "step functions" "state machine" is created then a S3 task is configured on the state machine
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a "step functions" "state machine" is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a S3 task is configured on the state machine
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then a "step functions" "state machine" is created
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then a "s3" "bucket" is created
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "s3" "bucket" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a S3 task is configured on the state machine
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a "s3" "bucket" is created
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a S3 task is configured on the state machine
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a "s3" "bucket" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a S3 task is configured on the state machine
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then a "s3" "bucket" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then a S3 task is configured on the state machine
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "step functions" "state machine" is created then a "s3" "bucket" is created then a S3 task is configured on the state machine
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a "s3" "bucket" is created
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "step functions" "state machine" is created then a S3 task is configured on the state machine then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a S3 task is configured on the state machine
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "step functions" "state machine" is created then a running "step functions" "execution" fails to read because no object exists in the bucket then a "s3" "bucket" is created
    Given smid not in sm_status
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a "step functions" "state machine" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a "step functions" "state machine" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a S3 task is configured on the state machine then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a S3 task is configured on the state machine
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a "step functions" "state machine" is created
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a "s3" "bucket" is created then a running "step functions" "execution" fails to read because no object exists in the bucket then a S3 task is configured on the state machine
    Given bid not in bucket_status
    When a "s3" "bucket" is created
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then a "step functions" "state machine" is created then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then a "s3" "bucket" is created then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When a "s3" "bucket" is created
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a "step functions" "state machine" is created
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a "s3" "bucket" is created
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a S3 task is configured on the state machine then a running "step functions" "execution" fails to read because no object exists in the bucket then an "step functions" "execution" of the "step functions" "state machine" is started
    Given smid in sm_status
    When a S3 task is configured on the state machine
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "step functions" "state machine" is created then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a "s3" "bucket" is created then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a "s3" "bucket" is created
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a S3 task is configured on the state machine then a "step functions" "state machine" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a S3 task is configured on the state machine
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a "s3" "bucket" is created
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a S3 task is configured on the state machine
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" fails to read because no object exists in the bucket then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given smid in sm_status
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a "step functions" "state machine" is created then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a "step functions" "state machine" is created
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a "s3" "bucket" is created then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a "s3" "bucket" is created
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a S3 task is configured on the state machine then a "s3" "bucket" is created
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a S3 task is configured on the state machine
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a S3 task is configured on the state machine
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a running "step functions" "execution" fails to read because no object exists in the bucket then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a "step functions" "state machine" is created then a "s3" "bucket" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a "step functions" "state machine" is created
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a "s3" "bucket" is created then a S3 task is configured on the state machine
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a "s3" "bucket" is created
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a S3 task is configured on the state machine then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a S3 task is configured on the state machine
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a running "step functions" "execution" fails to read because no object exists in the bucket
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a running "step functions" "execution" fails to read because no object exists in the bucket then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then a "step functions" "state machine" is created then a S3 task is configured on the state machine
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a "step functions" "state machine" is created
    When a S3 task is configured on the state machine
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then a "s3" "bucket" is created then an "step functions" "execution" of the "step functions" "state machine" is started
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a "s3" "bucket" is created
    When an "step functions" "execution" of the "step functions" "state machine" is started
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then a S3 task is configured on the state machine then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a S3 task is configured on the state machine
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then an "step functions" "execution" of the "step functions" "state machine" is started then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When an "step functions" "execution" of the "step functions" "state machine" is started
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds then a "step functions" "state machine" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a running "step functions" "execution" writes an object to the "s3" "bucket" and succeeds
    When a "step functions" "state machine" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket

  @sequence
  Scenario: a running "step functions" "execution" fails to read because no object exists in the bucket then a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds then a "s3" "bucket" is created
    Given eid in exec_status
    When a running "step functions" "execution" fails to read because no object exists in the bucket
    When a running "step functions" "execution" reads an existing object from the "s3" "bucket" and succeeds
    When a "s3" "bucket" is created
    And every "RUNNING" execution references an "ACTIVE" state machine
    And every existing object belongs to an "ACTIVE" bucket
