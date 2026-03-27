@lambda @generated
Feature: Lambda - Action Sequences

  # Generated from FizzBee spec: lambda.fizz
  # Safety invariants: ActiveMappingReferencesActiveFunction, NoExecutionsOnDeletingFunction, ConcurrencyLimitRespected, AsyncRetryLimitRespected, ValidEventSourceMappingStatus, ValidFunctionStatus, AsyncSlotsReferenceKnownFunctions

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a function is created then a pending function resolves its deployment
    Given fid not in func_status
    Given a function has been created
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an active function is deleted
    Given fid not in func_status
    Given a function has been created
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a failed function is deleted
    Given fid not in func_status
    Given a function has been created
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function finishes being deleted
    Given fid not in func_status
    Given a function has been created
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function's code is updated
    Given fid not in func_status
    Given a function has been created
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function's configuration is updated
    Given fid not in func_status
    Given a function has been created
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then reserved concurrency is set for a function
    Given fid not in func_status
    Given a function has been created
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function is invoked synchronously without a concurrency limit
    Given fid not in func_status
    Given a function has been created
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function is invoked synchronously within its concurrency limit
    Given fid not in func_status
    Given a function has been created
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a synchronous function invocation completes
    Given fid not in func_status
    Given a function has been created
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function is invoked asynchronously
    Given fid not in func_status
    Given a function has been created
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an async invocation succeeds
    Given fid not in func_status
    Given a function has been created
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an async invocation fails and is retried
    Given fid not in func_status
    Given a function has been created
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an async invocation exhausts all retries
    Given fid not in func_status
    Given a function has been created
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an event source mapping is created
    Given fid not in func_status
    Given a function has been created
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an event source mapping finishes creating
    Given fid not in func_status
    Given a function has been created
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a disabled event source mapping is enabled
    Given fid not in func_status
    Given a function has been created
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an enabled event source mapping is disabled
    Given fid not in func_status
    Given a function has been created
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an enabled event source mapping is deleted
    Given fid not in func_status
    Given a function has been created
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a disabled event source mapping is deleted
    Given fid not in func_status
    Given a function has been created
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an event source mapping finishes being deleted
    Given fid not in func_status
    Given a function has been created
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a tag is added to a function
    Given fid not in func_status
    Given a function has been created
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a tag is removed from a function
    Given fid not in func_status
    Given a function has been created
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a permission is added to a function's resource policy
    Given fid not in func_status
    Given a function has been created
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a permission is removed from a function's resource policy
    Given fid not in func_status
    Given a function has been created
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function is created
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an active function is deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a failed function is deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function finishes being deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function's code is updated
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function's configuration is updated
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then reserved concurrency is set for a function
    Given fid in func_status
    Given a pending function has resolved its deployment
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a synchronous function invocation completes
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function is invoked asynchronously
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an async invocation succeeds
    Given fid in func_status
    Given a pending function has resolved its deployment
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an async invocation fails and is retried
    Given fid in func_status
    Given a pending function has resolved its deployment
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an async invocation exhausts all retries
    Given fid in func_status
    Given a pending function has resolved its deployment
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an event source mapping is created
    Given fid in func_status
    Given a pending function has resolved its deployment
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an event source mapping finishes creating
    Given fid in func_status
    Given a pending function has resolved its deployment
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a disabled event source mapping is enabled
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an enabled event source mapping is disabled
    Given fid in func_status
    Given a pending function has resolved its deployment
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an enabled event source mapping is deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a disabled event source mapping is deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an event source mapping finishes being deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a tag is added to a function
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a tag is removed from a function
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a permission is added to a function's resource policy
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a pending function has resolved its deployment
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function is created
    Given fid in func_status
    Given an active function has been deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a pending function resolves its deployment
    Given fid in func_status
    Given an active function has been deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a failed function is deleted
    Given fid in func_status
    Given an active function has been deleted
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function finishes being deleted
    Given fid in func_status
    Given an active function has been deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function's code is updated
    Given fid in func_status
    Given an active function has been deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function's configuration is updated
    Given fid in func_status
    Given an active function has been deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then reserved concurrency is set for a function
    Given fid in func_status
    Given an active function has been deleted
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given an active function has been deleted
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given an active function has been deleted
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a synchronous function invocation completes
    Given fid in func_status
    Given an active function has been deleted
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function is invoked asynchronously
    Given fid in func_status
    Given an active function has been deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an async invocation succeeds
    Given fid in func_status
    Given an active function has been deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an async invocation fails and is retried
    Given fid in func_status
    Given an active function has been deleted
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an async invocation exhausts all retries
    Given fid in func_status
    Given an active function has been deleted
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an event source mapping is created
    Given fid in func_status
    Given an active function has been deleted
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an event source mapping finishes creating
    Given fid in func_status
    Given an active function has been deleted
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a disabled event source mapping is enabled
    Given fid in func_status
    Given an active function has been deleted
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an enabled event source mapping is disabled
    Given fid in func_status
    Given an active function has been deleted
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an enabled event source mapping is deleted
    Given fid in func_status
    Given an active function has been deleted
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a disabled event source mapping is deleted
    Given fid in func_status
    Given an active function has been deleted
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an event source mapping finishes being deleted
    Given fid in func_status
    Given an active function has been deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a tag is added to a function
    Given fid in func_status
    Given an active function has been deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a tag is removed from a function
    Given fid in func_status
    Given an active function has been deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a permission is added to a function's resource policy
    Given fid in func_status
    Given an active function has been deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a permission is removed from a function's resource policy
    Given fid in func_status
    Given an active function has been deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function is created
    Given fid in func_status
    Given a failed function has been deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a pending function resolves its deployment
    Given fid in func_status
    Given a failed function has been deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an active function is deleted
    Given fid in func_status
    Given a failed function has been deleted
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function finishes being deleted
    Given fid in func_status
    Given a failed function has been deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function's code is updated
    Given fid in func_status
    Given a failed function has been deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function's configuration is updated
    Given fid in func_status
    Given a failed function has been deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then reserved concurrency is set for a function
    Given fid in func_status
    Given a failed function has been deleted
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a failed function has been deleted
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a failed function has been deleted
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a synchronous function invocation completes
    Given fid in func_status
    Given a failed function has been deleted
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function is invoked asynchronously
    Given fid in func_status
    Given a failed function has been deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an async invocation succeeds
    Given fid in func_status
    Given a failed function has been deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an async invocation fails and is retried
    Given fid in func_status
    Given a failed function has been deleted
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an async invocation exhausts all retries
    Given fid in func_status
    Given a failed function has been deleted
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an event source mapping is created
    Given fid in func_status
    Given a failed function has been deleted
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an event source mapping finishes creating
    Given fid in func_status
    Given a failed function has been deleted
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a disabled event source mapping is enabled
    Given fid in func_status
    Given a failed function has been deleted
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an enabled event source mapping is disabled
    Given fid in func_status
    Given a failed function has been deleted
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an enabled event source mapping is deleted
    Given fid in func_status
    Given a failed function has been deleted
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a disabled event source mapping is deleted
    Given fid in func_status
    Given a failed function has been deleted
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an event source mapping finishes being deleted
    Given fid in func_status
    Given a failed function has been deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a tag is added to a function
    Given fid in func_status
    Given a failed function has been deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a tag is removed from a function
    Given fid in func_status
    Given a failed function has been deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a permission is added to a function's resource policy
    Given fid in func_status
    Given a failed function has been deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a failed function has been deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function is created
    Given fid in func_status
    Given a function has finished being deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a pending function resolves its deployment
    Given fid in func_status
    Given a function has finished being deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an active function is deleted
    Given fid in func_status
    Given a function has finished being deleted
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a failed function is deleted
    Given fid in func_status
    Given a function has finished being deleted
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function's code is updated
    Given fid in func_status
    Given a function has finished being deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function's configuration is updated
    Given fid in func_status
    Given a function has finished being deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then reserved concurrency is set for a function
    Given fid in func_status
    Given a function has finished being deleted
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a function has finished being deleted
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a function has finished being deleted
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a synchronous function invocation completes
    Given fid in func_status
    Given a function has finished being deleted
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function is invoked asynchronously
    Given fid in func_status
    Given a function has finished being deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an async invocation succeeds
    Given fid in func_status
    Given a function has finished being deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an async invocation fails and is retried
    Given fid in func_status
    Given a function has finished being deleted
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an async invocation exhausts all retries
    Given fid in func_status
    Given a function has finished being deleted
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an event source mapping is created
    Given fid in func_status
    Given a function has finished being deleted
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an event source mapping finishes creating
    Given fid in func_status
    Given a function has finished being deleted
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function has finished being deleted
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function has finished being deleted
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function has finished being deleted
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function has finished being deleted
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function has finished being deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a tag is added to a function
    Given fid in func_status
    Given a function has finished being deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a tag is removed from a function
    Given fid in func_status
    Given a function has finished being deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function has finished being deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function has finished being deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function is created
    Given fid in func_status
    Given a function's code has been updated
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a pending function resolves its deployment
    Given fid in func_status
    Given a function's code has been updated
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an active function is deleted
    Given fid in func_status
    Given a function's code has been updated
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a failed function is deleted
    Given fid in func_status
    Given a function's code has been updated
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function finishes being deleted
    Given fid in func_status
    Given a function's code has been updated
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function's configuration is updated
    Given fid in func_status
    Given a function's code has been updated
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then reserved concurrency is set for a function
    Given fid in func_status
    Given a function's code has been updated
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a function's code has been updated
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a function's code has been updated
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a synchronous function invocation completes
    Given fid in func_status
    Given a function's code has been updated
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function is invoked asynchronously
    Given fid in func_status
    Given a function's code has been updated
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an async invocation succeeds
    Given fid in func_status
    Given a function's code has been updated
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an async invocation fails and is retried
    Given fid in func_status
    Given a function's code has been updated
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an async invocation exhausts all retries
    Given fid in func_status
    Given a function's code has been updated
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an event source mapping is created
    Given fid in func_status
    Given a function's code has been updated
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an event source mapping finishes creating
    Given fid in func_status
    Given a function's code has been updated
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function's code has been updated
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function's code has been updated
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function's code has been updated
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function's code has been updated
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function's code has been updated
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a tag is added to a function
    Given fid in func_status
    Given a function's code has been updated
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a tag is removed from a function
    Given fid in func_status
    Given a function's code has been updated
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function's code has been updated
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function's code has been updated
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function is created
    Given fid in func_status
    Given a function's configuration has been updated
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a pending function resolves its deployment
    Given fid in func_status
    Given a function's configuration has been updated
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an active function is deleted
    Given fid in func_status
    Given a function's configuration has been updated
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a failed function is deleted
    Given fid in func_status
    Given a function's configuration has been updated
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function finishes being deleted
    Given fid in func_status
    Given a function's configuration has been updated
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function's code is updated
    Given fid in func_status
    Given a function's configuration has been updated
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then reserved concurrency is set for a function
    Given fid in func_status
    Given a function's configuration has been updated
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a function's configuration has been updated
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a function's configuration has been updated
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a synchronous function invocation completes
    Given fid in func_status
    Given a function's configuration has been updated
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function is invoked asynchronously
    Given fid in func_status
    Given a function's configuration has been updated
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an async invocation succeeds
    Given fid in func_status
    Given a function's configuration has been updated
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an async invocation fails and is retried
    Given fid in func_status
    Given a function's configuration has been updated
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an async invocation exhausts all retries
    Given fid in func_status
    Given a function's configuration has been updated
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an event source mapping is created
    Given fid in func_status
    Given a function's configuration has been updated
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an event source mapping finishes creating
    Given fid in func_status
    Given a function's configuration has been updated
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function's configuration has been updated
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function's configuration has been updated
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function's configuration has been updated
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function's configuration has been updated
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function's configuration has been updated
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a tag is added to a function
    Given fid in func_status
    Given a function's configuration has been updated
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a tag is removed from a function
    Given fid in func_status
    Given a function's configuration has been updated
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function's configuration has been updated
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function's configuration has been updated
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function is created
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a pending function resolves its deployment
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an active function is deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a failed function is deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function finishes being deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function's code is updated
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function's configuration is updated
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a synchronous function invocation completes
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function is invoked asynchronously
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an async invocation succeeds
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an async invocation fails and is retried
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an async invocation exhausts all retries
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an event source mapping is created
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an event source mapping finishes creating
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a disabled event source mapping is enabled
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an enabled event source mapping is disabled
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an enabled event source mapping is deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a disabled event source mapping is deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an event source mapping finishes being deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a tag is added to a function
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a tag is removed from a function
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a permission is added to a function's resource policy
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a permission is removed from a function's resource policy
    Given fid in func_status
    Given reserved concurrency has been set for a function
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function is created
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a pending function resolves its deployment
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an active function is deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a failed function is deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function finishes being deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function's code is updated
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function's configuration is updated
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then reserved concurrency is set for a function
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a synchronous function invocation completes
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function is invoked asynchronously
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an async invocation succeeds
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an async invocation fails and is retried
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an async invocation exhausts all retries
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an event source mapping is created
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an event source mapping finishes creating
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a tag is added to a function
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a tag is removed from a function
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function is created
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a pending function resolves its deployment
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an active function is deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a failed function is deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function finishes being deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function's code is updated
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function's configuration is updated
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then reserved concurrency is set for a function
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a synchronous function invocation completes
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function is invoked asynchronously
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an async invocation succeeds
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an async invocation fails and is retried
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an async invocation exhausts all retries
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an event source mapping is created
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an event source mapping finishes creating
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a tag is added to a function
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a tag is removed from a function
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function is created
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a pending function resolves its deployment
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an active function is deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a failed function is deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function finishes being deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function's code is updated
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function's configuration is updated
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then reserved concurrency is set for a function
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function is invoked synchronously without a concurrency limit
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function is invoked synchronously within its concurrency limit
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function is invoked asynchronously
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an async invocation succeeds
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an async invocation fails and is retried
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an async invocation exhausts all retries
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an event source mapping is created
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an event source mapping finishes creating
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a disabled event source mapping is enabled
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an enabled event source mapping is disabled
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an enabled event source mapping is deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a disabled event source mapping is deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an event source mapping finishes being deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a tag is added to a function
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a tag is removed from a function
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a permission is added to a function's resource policy
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a permission is removed from a function's resource policy
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function is created
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a pending function resolves its deployment
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an active function is deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a failed function is deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function finishes being deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function's code is updated
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function's configuration is updated
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then reserved concurrency is set for a function
    Given fid in func_status
    Given a function has been invoked asynchronously
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a synchronous function invocation completes
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an async invocation succeeds
    Given fid in func_status
    Given a function has been invoked asynchronously
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an async invocation fails and is retried
    Given fid in func_status
    Given a function has been invoked asynchronously
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an async invocation exhausts all retries
    Given fid in func_status
    Given a function has been invoked asynchronously
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an event source mapping is created
    Given fid in func_status
    Given a function has been invoked asynchronously
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an event source mapping finishes creating
    Given fid in func_status
    Given a function has been invoked asynchronously
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function has been invoked asynchronously
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a tag is added to a function
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a tag is removed from a function
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function has been invoked asynchronously
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function is created
    Given slot in async_func
    Given an async invocation has succeeded
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a pending function resolves its deployment
    Given slot in async_func
    Given an async invocation has succeeded
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an active function is deleted
    Given slot in async_func
    Given an async invocation has succeeded
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a failed function is deleted
    Given slot in async_func
    Given an async invocation has succeeded
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function finishes being deleted
    Given slot in async_func
    Given an async invocation has succeeded
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function's code is updated
    Given slot in async_func
    Given an async invocation has succeeded
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function's configuration is updated
    Given slot in async_func
    Given an async invocation has succeeded
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then reserved concurrency is set for a function
    Given slot in async_func
    Given an async invocation has succeeded
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function is invoked synchronously without a concurrency limit
    Given slot in async_func
    Given an async invocation has succeeded
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function is invoked synchronously within its concurrency limit
    Given slot in async_func
    Given an async invocation has succeeded
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a synchronous function invocation completes
    Given slot in async_func
    Given an async invocation has succeeded
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function is invoked asynchronously
    Given slot in async_func
    Given an async invocation has succeeded
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an async invocation fails and is retried
    Given slot in async_func
    Given an async invocation has succeeded
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an async invocation exhausts all retries
    Given slot in async_func
    Given an async invocation has succeeded
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an event source mapping is created
    Given slot in async_func
    Given an async invocation has succeeded
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an event source mapping finishes creating
    Given slot in async_func
    Given an async invocation has succeeded
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a disabled event source mapping is enabled
    Given slot in async_func
    Given an async invocation has succeeded
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an enabled event source mapping is disabled
    Given slot in async_func
    Given an async invocation has succeeded
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an enabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has succeeded
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a disabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has succeeded
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an event source mapping finishes being deleted
    Given slot in async_func
    Given an async invocation has succeeded
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a tag is added to a function
    Given slot in async_func
    Given an async invocation has succeeded
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a tag is removed from a function
    Given slot in async_func
    Given an async invocation has succeeded
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a permission is added to a function's resource policy
    Given slot in async_func
    Given an async invocation has succeeded
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a permission is removed from a function's resource policy
    Given slot in async_func
    Given an async invocation has succeeded
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function is created
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a pending function resolves its deployment
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an active function is deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a failed function is deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function finishes being deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function's code is updated
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function's configuration is updated
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then reserved concurrency is set for a function
    Given slot in async_func
    Given an async invocation has failed and been retried
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function is invoked synchronously without a concurrency limit
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function is invoked synchronously within its concurrency limit
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a synchronous function invocation completes
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function is invoked asynchronously
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an async invocation succeeds
    Given slot in async_func
    Given an async invocation has failed and been retried
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an async invocation exhausts all retries
    Given slot in async_func
    Given an async invocation has failed and been retried
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an event source mapping is created
    Given slot in async_func
    Given an async invocation has failed and been retried
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an event source mapping finishes creating
    Given slot in async_func
    Given an async invocation has failed and been retried
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a disabled event source mapping is enabled
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an enabled event source mapping is disabled
    Given slot in async_func
    Given an async invocation has failed and been retried
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an enabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a disabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an event source mapping finishes being deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a tag is added to a function
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a tag is removed from a function
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a permission is added to a function's resource policy
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a permission is removed from a function's resource policy
    Given slot in async_func
    Given an async invocation has failed and been retried
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function is created
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a pending function resolves its deployment
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an active function is deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a failed function is deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function finishes being deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function's code is updated
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function's configuration is updated
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then reserved concurrency is set for a function
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function is invoked synchronously without a concurrency limit
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function is invoked synchronously within its concurrency limit
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a synchronous function invocation completes
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function is invoked asynchronously
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an async invocation succeeds
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an async invocation fails and is retried
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an event source mapping is created
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an event source mapping finishes creating
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a disabled event source mapping is enabled
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an enabled event source mapping is disabled
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an enabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a disabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an event source mapping finishes being deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a tag is added to a function
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a tag is removed from a function
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a permission is added to a function's resource policy
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a permission is removed from a function's resource policy
    Given slot in async_func
    Given an async invocation has exhausted all retries
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function is created
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a pending function resolves its deployment
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an active function is deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a failed function is deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function finishes being deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function's code is updated
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function's configuration is updated
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then reserved concurrency is set for a function
    Given mid not in mapping_status
    Given an event source mapping has been created
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function is invoked synchronously without a concurrency limit
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function is invoked synchronously within its concurrency limit
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a synchronous function invocation completes
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function is invoked asynchronously
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an async invocation succeeds
    Given mid not in mapping_status
    Given an event source mapping has been created
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an async invocation fails and is retried
    Given mid not in mapping_status
    Given an event source mapping has been created
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an async invocation exhausts all retries
    Given mid not in mapping_status
    Given an event source mapping has been created
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an event source mapping finishes creating
    Given mid not in mapping_status
    Given an event source mapping has been created
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a disabled event source mapping is enabled
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an enabled event source mapping is disabled
    Given mid not in mapping_status
    Given an event source mapping has been created
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an enabled event source mapping is deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a disabled event source mapping is deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an event source mapping finishes being deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a tag is added to a function
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a tag is removed from a function
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a permission is added to a function's resource policy
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a permission is removed from a function's resource policy
    Given mid not in mapping_status
    Given an event source mapping has been created
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function is created
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a pending function resolves its deployment
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an active function is deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a failed function is deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function finishes being deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function's code is updated
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function's configuration is updated
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then reserved concurrency is set for a function
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a synchronous function invocation completes
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function is invoked asynchronously
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an async invocation succeeds
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an async invocation fails and is retried
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an async invocation exhausts all retries
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an event source mapping is created
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a disabled event source mapping is enabled
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an enabled event source mapping is disabled
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an enabled event source mapping is deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a disabled event source mapping is deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an event source mapping finishes being deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a tag is added to a function
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a tag is removed from a function
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given an event source mapping has finished creating
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function is created
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a pending function resolves its deployment
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an active function is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a failed function is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function finishes being deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function's code is updated
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function's configuration is updated
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then reserved concurrency is set for a function
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a synchronous function invocation completes
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function is invoked asynchronously
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an async invocation succeeds
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an async invocation fails and is retried
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an async invocation exhausts all retries
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an event source mapping is created
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an event source mapping finishes creating
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an enabled event source mapping is disabled
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an enabled event source mapping is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a disabled event source mapping is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an event source mapping finishes being deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a tag is added to a function
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a tag is removed from a function
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function is created
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a pending function resolves its deployment
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an active function is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a failed function is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function finishes being deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function's code is updated
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function's configuration is updated
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then reserved concurrency is set for a function
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a synchronous function invocation completes
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function is invoked asynchronously
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an async invocation succeeds
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an async invocation fails and is retried
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an async invocation exhausts all retries
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an event source mapping is created
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an event source mapping finishes creating
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a disabled event source mapping is enabled
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an enabled event source mapping is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a disabled event source mapping is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an event source mapping finishes being deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a tag is added to a function
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a tag is removed from a function
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function is created
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a pending function resolves its deployment
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an active function is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a failed function is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function finishes being deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function's code is updated
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function's configuration is updated
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then reserved concurrency is set for a function
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a synchronous function invocation completes
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function is invoked asynchronously
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an async invocation succeeds
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an async invocation fails and is retried
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an async invocation exhausts all retries
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an event source mapping is created
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an event source mapping finishes creating
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a disabled event source mapping is enabled
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an enabled event source mapping is disabled
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a disabled event source mapping is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an event source mapping finishes being deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a tag is added to a function
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a tag is removed from a function
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function is created
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a pending function resolves its deployment
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an active function is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a failed function is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function finishes being deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function's code is updated
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function's configuration is updated
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then reserved concurrency is set for a function
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a synchronous function invocation completes
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function is invoked asynchronously
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an async invocation succeeds
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an async invocation fails and is retried
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an async invocation exhausts all retries
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an event source mapping is created
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an event source mapping finishes creating
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a disabled event source mapping is enabled
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an enabled event source mapping is disabled
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an enabled event source mapping is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an event source mapping finishes being deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a tag is added to a function
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a tag is removed from a function
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function is created
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a pending function resolves its deployment
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an active function is deleted
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a failed function is deleted
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function finishes being deleted
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function's code is updated
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function's configuration is updated
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then reserved concurrency is set for a function
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a synchronous function invocation completes
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function is invoked asynchronously
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an async invocation succeeds
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an async invocation fails and is retried
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an async invocation exhausts all retries
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an event source mapping is created
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an event source mapping finishes creating
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a disabled event source mapping is enabled
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an enabled event source mapping is disabled
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an enabled event source mapping is deleted
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a disabled event source mapping is deleted
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a tag is added to a function
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a tag is removed from a function
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function is created
    Given fid in func_status
    Given a tag has been added to a function
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a pending function resolves its deployment
    Given fid in func_status
    Given a tag has been added to a function
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an active function is deleted
    Given fid in func_status
    Given a tag has been added to a function
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a failed function is deleted
    Given fid in func_status
    Given a tag has been added to a function
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function finishes being deleted
    Given fid in func_status
    Given a tag has been added to a function
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function's code is updated
    Given fid in func_status
    Given a tag has been added to a function
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function's configuration is updated
    Given fid in func_status
    Given a tag has been added to a function
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then reserved concurrency is set for a function
    Given fid in func_status
    Given a tag has been added to a function
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a tag has been added to a function
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a tag has been added to a function
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a synchronous function invocation completes
    Given fid in func_status
    Given a tag has been added to a function
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function is invoked asynchronously
    Given fid in func_status
    Given a tag has been added to a function
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an async invocation succeeds
    Given fid in func_status
    Given a tag has been added to a function
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an async invocation fails and is retried
    Given fid in func_status
    Given a tag has been added to a function
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an async invocation exhausts all retries
    Given fid in func_status
    Given a tag has been added to a function
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an event source mapping is created
    Given fid in func_status
    Given a tag has been added to a function
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an event source mapping finishes creating
    Given fid in func_status
    Given a tag has been added to a function
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a disabled event source mapping is enabled
    Given fid in func_status
    Given a tag has been added to a function
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an enabled event source mapping is disabled
    Given fid in func_status
    Given a tag has been added to a function
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an enabled event source mapping is deleted
    Given fid in func_status
    Given a tag has been added to a function
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a disabled event source mapping is deleted
    Given fid in func_status
    Given a tag has been added to a function
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an event source mapping finishes being deleted
    Given fid in func_status
    Given a tag has been added to a function
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a tag is removed from a function
    Given fid in func_status
    Given a tag has been added to a function
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a permission is added to a function's resource policy
    Given fid in func_status
    Given a tag has been added to a function
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a tag has been added to a function
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function is created
    Given fid in func_status
    Given a tag has been removed from a function
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a pending function resolves its deployment
    Given fid in func_status
    Given a tag has been removed from a function
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an active function is deleted
    Given fid in func_status
    Given a tag has been removed from a function
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a failed function is deleted
    Given fid in func_status
    Given a tag has been removed from a function
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function finishes being deleted
    Given fid in func_status
    Given a tag has been removed from a function
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function's code is updated
    Given fid in func_status
    Given a tag has been removed from a function
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function's configuration is updated
    Given fid in func_status
    Given a tag has been removed from a function
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then reserved concurrency is set for a function
    Given fid in func_status
    Given a tag has been removed from a function
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a tag has been removed from a function
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a tag has been removed from a function
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a synchronous function invocation completes
    Given fid in func_status
    Given a tag has been removed from a function
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function is invoked asynchronously
    Given fid in func_status
    Given a tag has been removed from a function
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an async invocation succeeds
    Given fid in func_status
    Given a tag has been removed from a function
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an async invocation fails and is retried
    Given fid in func_status
    Given a tag has been removed from a function
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an async invocation exhausts all retries
    Given fid in func_status
    Given a tag has been removed from a function
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an event source mapping is created
    Given fid in func_status
    Given a tag has been removed from a function
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an event source mapping finishes creating
    Given fid in func_status
    Given a tag has been removed from a function
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a disabled event source mapping is enabled
    Given fid in func_status
    Given a tag has been removed from a function
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an enabled event source mapping is disabled
    Given fid in func_status
    Given a tag has been removed from a function
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an enabled event source mapping is deleted
    Given fid in func_status
    Given a tag has been removed from a function
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a disabled event source mapping is deleted
    Given fid in func_status
    Given a tag has been removed from a function
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an event source mapping finishes being deleted
    Given fid in func_status
    Given a tag has been removed from a function
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a tag is added to a function
    Given fid in func_status
    Given a tag has been removed from a function
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a permission is added to a function's resource policy
    Given fid in func_status
    Given a tag has been removed from a function
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a tag has been removed from a function
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function is created
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a pending function resolves its deployment
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an active function is deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a failed function is deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function finishes being deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function's code is updated
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function's configuration is updated
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then reserved concurrency is set for a function
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a synchronous function invocation completes
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function is invoked asynchronously
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an async invocation succeeds
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an async invocation fails and is retried
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an async invocation exhausts all retries
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an event source mapping is created
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an event source mapping finishes creating
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a disabled event source mapping is enabled
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an enabled event source mapping is disabled
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an enabled event source mapping is deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a disabled event source mapping is deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an event source mapping finishes being deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a tag is added to a function
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a tag is removed from a function
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function is created
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a pending function resolves its deployment
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an active function is deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a failed function is deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function finishes being deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function's code is updated
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function's configuration is updated
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then reserved concurrency is set for a function
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function is invoked synchronously without a concurrency limit
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function is invoked synchronously within its concurrency limit
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a synchronous function invocation completes
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function is invoked asynchronously
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an async invocation succeeds
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an async invocation fails and is retried
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an async invocation exhausts all retries
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an event source mapping is created
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an event source mapping finishes creating
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a disabled event source mapping is enabled
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an enabled event source mapping is disabled
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an enabled event source mapping is deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a disabled event source mapping is deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an event source mapping finishes being deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a tag is added to a function
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a tag is removed from a function
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a permission is added to a function's resource policy
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a pending function resolves its deployment then an active function is deleted
    Given fid not in func_status
    Given a function has been created
    Given a pending function has resolved its deployment
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an active function is deleted then a failed function is deleted
    Given fid not in func_status
    Given a function has been created
    Given an active function has been deleted
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a failed function is deleted then a function finishes being deleted
    Given fid not in func_status
    Given a function has been created
    Given a failed function has been deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function finishes being deleted then a function's code is updated
    Given fid not in func_status
    Given a function has been created
    Given a function has finished being deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function's code is updated then a function's configuration is updated
    Given fid not in func_status
    Given a function has been created
    Given a function's code has been updated
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function's configuration is updated then reserved concurrency is set for a function
    Given fid not in func_status
    Given a function has been created
    Given a function's configuration has been updated
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then reserved concurrency is set for a function then a function is invoked synchronously without a concurrency limit
    Given fid not in func_status
    Given a function has been created
    Given reserved concurrency has been set for a function
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function is invoked synchronously without a concurrency limit then a function is invoked synchronously within its concurrency limit
    Given fid not in func_status
    Given a function has been created
    Given a function has been invoked synchronously without a concurrency limit
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function is invoked synchronously within its concurrency limit then a synchronous function invocation completes
    Given fid not in func_status
    Given a function has been created
    Given a function has been invoked synchronously within its concurrency limit
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a synchronous function invocation completes then a function is invoked asynchronously
    Given fid not in func_status
    Given a function has been created
    Given a synchronous function invocation has completed
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a function is invoked asynchronously then an async invocation succeeds
    Given fid not in func_status
    Given a function has been created
    Given a function has been invoked asynchronously
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an async invocation succeeds then an async invocation fails and is retried
    Given fid not in func_status
    Given a function has been created
    Given an async invocation has succeeded
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an async invocation fails and is retried then an async invocation exhausts all retries
    Given fid not in func_status
    Given a function has been created
    Given an async invocation has failed and been retried
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an async invocation exhausts all retries then an event source mapping is created
    Given fid not in func_status
    Given a function has been created
    Given an async invocation has exhausted all retries
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an event source mapping is created then an event source mapping finishes creating
    Given fid not in func_status
    Given a function has been created
    Given an event source mapping has been created
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an event source mapping finishes creating then a disabled event source mapping is enabled
    Given fid not in func_status
    Given a function has been created
    Given an event source mapping has finished creating
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a disabled event source mapping is enabled then an enabled event source mapping is disabled
    Given fid not in func_status
    Given a function has been created
    Given a disabled event source mapping has been enabled
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an enabled event source mapping is disabled then an enabled event source mapping is deleted
    Given fid not in func_status
    Given a function has been created
    Given an enabled event source mapping has been disabled
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an enabled event source mapping is deleted then a disabled event source mapping is deleted
    Given fid not in func_status
    Given a function has been created
    Given an enabled event source mapping has been deleted
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a disabled event source mapping is deleted then an event source mapping finishes being deleted
    Given fid not in func_status
    Given a function has been created
    Given a disabled event source mapping has been deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then an event source mapping finishes being deleted then a tag is added to a function
    Given fid not in func_status
    Given a function has been created
    Given an event source mapping has finished being deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a tag is added to a function then a tag is removed from a function
    Given fid not in func_status
    Given a function has been created
    Given a tag has been added to a function
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a tag is removed from a function then a permission is added to a function's resource policy
    Given fid not in func_status
    Given a function has been created
    Given a tag has been removed from a function
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a permission is added to a function's resource policy then a permission is removed from a function's resource policy
    Given fid not in func_status
    Given a function has been created
    Given a permission has been added to a function's resource policy
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is created then a permission is removed from a function's resource policy then a pending function resolves its deployment
    Given fid not in func_status
    Given a function has been created
    Given a permission has been removed from a function's resource policy
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function is created then a failed function is deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a function has been created
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an active function is deleted then a function finishes being deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given an active function has been deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a failed function is deleted then a function's code is updated
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a failed function has been deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function finishes being deleted then a function's configuration is updated
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a function has finished being deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function's code is updated then reserved concurrency is set for a function
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a function's code has been updated
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function's configuration is updated then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a function's configuration has been updated
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then reserved concurrency is set for a function then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given reserved concurrency has been set for a function
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function is invoked synchronously without a concurrency limit then a synchronous function invocation completes
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a function has been invoked synchronously without a concurrency limit
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function is invoked synchronously within its concurrency limit then a function is invoked asynchronously
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a function has been invoked synchronously within its concurrency limit
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a synchronous function invocation completes then an async invocation succeeds
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a synchronous function invocation has completed
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a function is invoked asynchronously then an async invocation fails and is retried
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a function has been invoked asynchronously
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an async invocation succeeds then an async invocation exhausts all retries
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given an async invocation has succeeded
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an async invocation fails and is retried then an event source mapping is created
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given an async invocation has failed and been retried
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an async invocation exhausts all retries then an event source mapping finishes creating
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given an async invocation has exhausted all retries
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an event source mapping is created then a disabled event source mapping is enabled
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given an event source mapping has been created
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an event source mapping finishes creating then an enabled event source mapping is disabled
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given an event source mapping has finished creating
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a disabled event source mapping is enabled then an enabled event source mapping is deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a disabled event source mapping has been enabled
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an enabled event source mapping is disabled then a disabled event source mapping is deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given an enabled event source mapping has been disabled
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an enabled event source mapping is deleted then an event source mapping finishes being deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given an enabled event source mapping has been deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a disabled event source mapping is deleted then a tag is added to a function
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a disabled event source mapping has been deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then an event source mapping finishes being deleted then a tag is removed from a function
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given an event source mapping has finished being deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a tag is added to a function then a permission is added to a function's resource policy
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a tag has been added to a function
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a tag is removed from a function then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a tag has been removed from a function
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a permission is added to a function's resource policy then a function is created
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a permission has been added to a function's resource policy
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a pending function resolves its deployment then a permission is removed from a function's resource policy then an active function is deleted
    Given fid in func_status
    Given a pending function has resolved its deployment
    Given a permission has been removed from a function's resource policy
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function is created then a function finishes being deleted
    Given fid in func_status
    Given an active function has been deleted
    Given a function has been created
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a pending function resolves its deployment then a function's code is updated
    Given fid in func_status
    Given an active function has been deleted
    Given a pending function has resolved its deployment
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a failed function is deleted then a function's configuration is updated
    Given fid in func_status
    Given an active function has been deleted
    Given a failed function has been deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function finishes being deleted then reserved concurrency is set for a function
    Given fid in func_status
    Given an active function has been deleted
    Given a function has finished being deleted
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function's code is updated then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given an active function has been deleted
    Given a function's code has been updated
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function's configuration is updated then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given an active function has been deleted
    Given a function's configuration has been updated
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then reserved concurrency is set for a function then a synchronous function invocation completes
    Given fid in func_status
    Given an active function has been deleted
    Given reserved concurrency has been set for a function
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function is invoked synchronously without a concurrency limit then a function is invoked asynchronously
    Given fid in func_status
    Given an active function has been deleted
    Given a function has been invoked synchronously without a concurrency limit
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function is invoked synchronously within its concurrency limit then an async invocation succeeds
    Given fid in func_status
    Given an active function has been deleted
    Given a function has been invoked synchronously within its concurrency limit
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a synchronous function invocation completes then an async invocation fails and is retried
    Given fid in func_status
    Given an active function has been deleted
    Given a synchronous function invocation has completed
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a function is invoked asynchronously then an async invocation exhausts all retries
    Given fid in func_status
    Given an active function has been deleted
    Given a function has been invoked asynchronously
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an async invocation succeeds then an event source mapping is created
    Given fid in func_status
    Given an active function has been deleted
    Given an async invocation has succeeded
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an async invocation fails and is retried then an event source mapping finishes creating
    Given fid in func_status
    Given an active function has been deleted
    Given an async invocation has failed and been retried
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an async invocation exhausts all retries then a disabled event source mapping is enabled
    Given fid in func_status
    Given an active function has been deleted
    Given an async invocation has exhausted all retries
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an event source mapping is created then an enabled event source mapping is disabled
    Given fid in func_status
    Given an active function has been deleted
    Given an event source mapping has been created
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an event source mapping finishes creating then an enabled event source mapping is deleted
    Given fid in func_status
    Given an active function has been deleted
    Given an event source mapping has finished creating
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a disabled event source mapping is enabled then a disabled event source mapping is deleted
    Given fid in func_status
    Given an active function has been deleted
    Given a disabled event source mapping has been enabled
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an enabled event source mapping is disabled then an event source mapping finishes being deleted
    Given fid in func_status
    Given an active function has been deleted
    Given an enabled event source mapping has been disabled
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an enabled event source mapping is deleted then a tag is added to a function
    Given fid in func_status
    Given an active function has been deleted
    Given an enabled event source mapping has been deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a disabled event source mapping is deleted then a tag is removed from a function
    Given fid in func_status
    Given an active function has been deleted
    Given a disabled event source mapping has been deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then an event source mapping finishes being deleted then a permission is added to a function's resource policy
    Given fid in func_status
    Given an active function has been deleted
    Given an event source mapping has finished being deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a tag is added to a function then a permission is removed from a function's resource policy
    Given fid in func_status
    Given an active function has been deleted
    Given a tag has been added to a function
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a tag is removed from a function then a function is created
    Given fid in func_status
    Given an active function has been deleted
    Given a tag has been removed from a function
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a permission is added to a function's resource policy then a pending function resolves its deployment
    Given fid in func_status
    Given an active function has been deleted
    Given a permission has been added to a function's resource policy
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an active function is deleted then a permission is removed from a function's resource policy then a failed function is deleted
    Given fid in func_status
    Given an active function has been deleted
    Given a permission has been removed from a function's resource policy
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function is created then a function's code is updated
    Given fid in func_status
    Given a failed function has been deleted
    Given a function has been created
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a pending function resolves its deployment then a function's configuration is updated
    Given fid in func_status
    Given a failed function has been deleted
    Given a pending function has resolved its deployment
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an active function is deleted then reserved concurrency is set for a function
    Given fid in func_status
    Given a failed function has been deleted
    Given an active function has been deleted
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function finishes being deleted then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a failed function has been deleted
    Given a function has finished being deleted
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function's code is updated then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a failed function has been deleted
    Given a function's code has been updated
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function's configuration is updated then a synchronous function invocation completes
    Given fid in func_status
    Given a failed function has been deleted
    Given a function's configuration has been updated
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then reserved concurrency is set for a function then a function is invoked asynchronously
    Given fid in func_status
    Given a failed function has been deleted
    Given reserved concurrency has been set for a function
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function is invoked synchronously without a concurrency limit then an async invocation succeeds
    Given fid in func_status
    Given a failed function has been deleted
    Given a function has been invoked synchronously without a concurrency limit
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function is invoked synchronously within its concurrency limit then an async invocation fails and is retried
    Given fid in func_status
    Given a failed function has been deleted
    Given a function has been invoked synchronously within its concurrency limit
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a synchronous function invocation completes then an async invocation exhausts all retries
    Given fid in func_status
    Given a failed function has been deleted
    Given a synchronous function invocation has completed
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a function is invoked asynchronously then an event source mapping is created
    Given fid in func_status
    Given a failed function has been deleted
    Given a function has been invoked asynchronously
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an async invocation succeeds then an event source mapping finishes creating
    Given fid in func_status
    Given a failed function has been deleted
    Given an async invocation has succeeded
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an async invocation fails and is retried then a disabled event source mapping is enabled
    Given fid in func_status
    Given a failed function has been deleted
    Given an async invocation has failed and been retried
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an async invocation exhausts all retries then an enabled event source mapping is disabled
    Given fid in func_status
    Given a failed function has been deleted
    Given an async invocation has exhausted all retries
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an event source mapping is created then an enabled event source mapping is deleted
    Given fid in func_status
    Given a failed function has been deleted
    Given an event source mapping has been created
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an event source mapping finishes creating then a disabled event source mapping is deleted
    Given fid in func_status
    Given a failed function has been deleted
    Given an event source mapping has finished creating
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a disabled event source mapping is enabled then an event source mapping finishes being deleted
    Given fid in func_status
    Given a failed function has been deleted
    Given a disabled event source mapping has been enabled
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an enabled event source mapping is disabled then a tag is added to a function
    Given fid in func_status
    Given a failed function has been deleted
    Given an enabled event source mapping has been disabled
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an enabled event source mapping is deleted then a tag is removed from a function
    Given fid in func_status
    Given a failed function has been deleted
    Given an enabled event source mapping has been deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a disabled event source mapping is deleted then a permission is added to a function's resource policy
    Given fid in func_status
    Given a failed function has been deleted
    Given a disabled event source mapping has been deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then an event source mapping finishes being deleted then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a failed function has been deleted
    Given an event source mapping has finished being deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a tag is added to a function then a function is created
    Given fid in func_status
    Given a failed function has been deleted
    Given a tag has been added to a function
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a tag is removed from a function then a pending function resolves its deployment
    Given fid in func_status
    Given a failed function has been deleted
    Given a tag has been removed from a function
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a permission is added to a function's resource policy then an active function is deleted
    Given fid in func_status
    Given a failed function has been deleted
    Given a permission has been added to a function's resource policy
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a failed function is deleted then a permission is removed from a function's resource policy then a function finishes being deleted
    Given fid in func_status
    Given a failed function has been deleted
    Given a permission has been removed from a function's resource policy
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function is created then a function's configuration is updated
    Given fid in func_status
    Given a function has finished being deleted
    Given a function has been created
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a pending function resolves its deployment then reserved concurrency is set for a function
    Given fid in func_status
    Given a function has finished being deleted
    Given a pending function has resolved its deployment
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an active function is deleted then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a function has finished being deleted
    Given an active function has been deleted
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a failed function is deleted then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a function has finished being deleted
    Given a failed function has been deleted
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function's code is updated then a synchronous function invocation completes
    Given fid in func_status
    Given a function has finished being deleted
    Given a function's code has been updated
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function's configuration is updated then a function is invoked asynchronously
    Given fid in func_status
    Given a function has finished being deleted
    Given a function's configuration has been updated
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then reserved concurrency is set for a function then an async invocation succeeds
    Given fid in func_status
    Given a function has finished being deleted
    Given reserved concurrency has been set for a function
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function is invoked synchronously without a concurrency limit then an async invocation fails and is retried
    Given fid in func_status
    Given a function has finished being deleted
    Given a function has been invoked synchronously without a concurrency limit
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function is invoked synchronously within its concurrency limit then an async invocation exhausts all retries
    Given fid in func_status
    Given a function has finished being deleted
    Given a function has been invoked synchronously within its concurrency limit
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a synchronous function invocation completes then an event source mapping is created
    Given fid in func_status
    Given a function has finished being deleted
    Given a synchronous function invocation has completed
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a function is invoked asynchronously then an event source mapping finishes creating
    Given fid in func_status
    Given a function has finished being deleted
    Given a function has been invoked asynchronously
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an async invocation succeeds then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function has finished being deleted
    Given an async invocation has succeeded
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an async invocation fails and is retried then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function has finished being deleted
    Given an async invocation has failed and been retried
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an async invocation exhausts all retries then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function has finished being deleted
    Given an async invocation has exhausted all retries
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an event source mapping is created then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function has finished being deleted
    Given an event source mapping has been created
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an event source mapping finishes creating then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function has finished being deleted
    Given an event source mapping has finished creating
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a disabled event source mapping is enabled then a tag is added to a function
    Given fid in func_status
    Given a function has finished being deleted
    Given a disabled event source mapping has been enabled
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an enabled event source mapping is disabled then a tag is removed from a function
    Given fid in func_status
    Given a function has finished being deleted
    Given an enabled event source mapping has been disabled
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an enabled event source mapping is deleted then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function has finished being deleted
    Given an enabled event source mapping has been deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a disabled event source mapping is deleted then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function has finished being deleted
    Given a disabled event source mapping has been deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then an event source mapping finishes being deleted then a function is created
    Given fid in func_status
    Given a function has finished being deleted
    Given an event source mapping has finished being deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a tag is added to a function then a pending function resolves its deployment
    Given fid in func_status
    Given a function has finished being deleted
    Given a tag has been added to a function
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a tag is removed from a function then an active function is deleted
    Given fid in func_status
    Given a function has finished being deleted
    Given a tag has been removed from a function
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a permission is added to a function's resource policy then a failed function is deleted
    Given fid in func_status
    Given a function has finished being deleted
    Given a permission has been added to a function's resource policy
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function finishes being deleted then a permission is removed from a function's resource policy then a function's code is updated
    Given fid in func_status
    Given a function has finished being deleted
    Given a permission has been removed from a function's resource policy
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function is created then reserved concurrency is set for a function
    Given fid in func_status
    Given a function's code has been updated
    Given a function has been created
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a pending function resolves its deployment then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a function's code has been updated
    Given a pending function has resolved its deployment
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an active function is deleted then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a function's code has been updated
    Given an active function has been deleted
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a failed function is deleted then a synchronous function invocation completes
    Given fid in func_status
    Given a function's code has been updated
    Given a failed function has been deleted
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function finishes being deleted then a function is invoked asynchronously
    Given fid in func_status
    Given a function's code has been updated
    Given a function has finished being deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function's configuration is updated then an async invocation succeeds
    Given fid in func_status
    Given a function's code has been updated
    Given a function's configuration has been updated
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then reserved concurrency is set for a function then an async invocation fails and is retried
    Given fid in func_status
    Given a function's code has been updated
    Given reserved concurrency has been set for a function
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function is invoked synchronously without a concurrency limit then an async invocation exhausts all retries
    Given fid in func_status
    Given a function's code has been updated
    Given a function has been invoked synchronously without a concurrency limit
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function is invoked synchronously within its concurrency limit then an event source mapping is created
    Given fid in func_status
    Given a function's code has been updated
    Given a function has been invoked synchronously within its concurrency limit
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a synchronous function invocation completes then an event source mapping finishes creating
    Given fid in func_status
    Given a function's code has been updated
    Given a synchronous function invocation has completed
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a function is invoked asynchronously then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function's code has been updated
    Given a function has been invoked asynchronously
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an async invocation succeeds then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function's code has been updated
    Given an async invocation has succeeded
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an async invocation fails and is retried then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function's code has been updated
    Given an async invocation has failed and been retried
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an async invocation exhausts all retries then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function's code has been updated
    Given an async invocation has exhausted all retries
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an event source mapping is created then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function's code has been updated
    Given an event source mapping has been created
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an event source mapping finishes creating then a tag is added to a function
    Given fid in func_status
    Given a function's code has been updated
    Given an event source mapping has finished creating
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a disabled event source mapping is enabled then a tag is removed from a function
    Given fid in func_status
    Given a function's code has been updated
    Given a disabled event source mapping has been enabled
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an enabled event source mapping is disabled then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function's code has been updated
    Given an enabled event source mapping has been disabled
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an enabled event source mapping is deleted then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function's code has been updated
    Given an enabled event source mapping has been deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a disabled event source mapping is deleted then a function is created
    Given fid in func_status
    Given a function's code has been updated
    Given a disabled event source mapping has been deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then an event source mapping finishes being deleted then a pending function resolves its deployment
    Given fid in func_status
    Given a function's code has been updated
    Given an event source mapping has finished being deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a tag is added to a function then an active function is deleted
    Given fid in func_status
    Given a function's code has been updated
    Given a tag has been added to a function
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a tag is removed from a function then a failed function is deleted
    Given fid in func_status
    Given a function's code has been updated
    Given a tag has been removed from a function
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a permission is added to a function's resource policy then a function finishes being deleted
    Given fid in func_status
    Given a function's code has been updated
    Given a permission has been added to a function's resource policy
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's code is updated then a permission is removed from a function's resource policy then a function's configuration is updated
    Given fid in func_status
    Given a function's code has been updated
    Given a permission has been removed from a function's resource policy
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function is created then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a function's configuration has been updated
    Given a function has been created
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a pending function resolves its deployment then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a function's configuration has been updated
    Given a pending function has resolved its deployment
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an active function is deleted then a synchronous function invocation completes
    Given fid in func_status
    Given a function's configuration has been updated
    Given an active function has been deleted
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a failed function is deleted then a function is invoked asynchronously
    Given fid in func_status
    Given a function's configuration has been updated
    Given a failed function has been deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function finishes being deleted then an async invocation succeeds
    Given fid in func_status
    Given a function's configuration has been updated
    Given a function has finished being deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function's code is updated then an async invocation fails and is retried
    Given fid in func_status
    Given a function's configuration has been updated
    Given a function's code has been updated
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then reserved concurrency is set for a function then an async invocation exhausts all retries
    Given fid in func_status
    Given a function's configuration has been updated
    Given reserved concurrency has been set for a function
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function is invoked synchronously without a concurrency limit then an event source mapping is created
    Given fid in func_status
    Given a function's configuration has been updated
    Given a function has been invoked synchronously without a concurrency limit
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function is invoked synchronously within its concurrency limit then an event source mapping finishes creating
    Given fid in func_status
    Given a function's configuration has been updated
    Given a function has been invoked synchronously within its concurrency limit
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a synchronous function invocation completes then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function's configuration has been updated
    Given a synchronous function invocation has completed
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a function is invoked asynchronously then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function's configuration has been updated
    Given a function has been invoked asynchronously
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an async invocation succeeds then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function's configuration has been updated
    Given an async invocation has succeeded
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an async invocation fails and is retried then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function's configuration has been updated
    Given an async invocation has failed and been retried
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an async invocation exhausts all retries then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function's configuration has been updated
    Given an async invocation has exhausted all retries
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an event source mapping is created then a tag is added to a function
    Given fid in func_status
    Given a function's configuration has been updated
    Given an event source mapping has been created
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an event source mapping finishes creating then a tag is removed from a function
    Given fid in func_status
    Given a function's configuration has been updated
    Given an event source mapping has finished creating
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a disabled event source mapping is enabled then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function's configuration has been updated
    Given a disabled event source mapping has been enabled
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an enabled event source mapping is disabled then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function's configuration has been updated
    Given an enabled event source mapping has been disabled
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an enabled event source mapping is deleted then a function is created
    Given fid in func_status
    Given a function's configuration has been updated
    Given an enabled event source mapping has been deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a disabled event source mapping is deleted then a pending function resolves its deployment
    Given fid in func_status
    Given a function's configuration has been updated
    Given a disabled event source mapping has been deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then an event source mapping finishes being deleted then an active function is deleted
    Given fid in func_status
    Given a function's configuration has been updated
    Given an event source mapping has finished being deleted
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a tag is added to a function then a failed function is deleted
    Given fid in func_status
    Given a function's configuration has been updated
    Given a tag has been added to a function
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a tag is removed from a function then a function finishes being deleted
    Given fid in func_status
    Given a function's configuration has been updated
    Given a tag has been removed from a function
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a permission is added to a function's resource policy then a function's code is updated
    Given fid in func_status
    Given a function's configuration has been updated
    Given a permission has been added to a function's resource policy
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function's configuration is updated then a permission is removed from a function's resource policy then reserved concurrency is set for a function
    Given fid in func_status
    Given a function's configuration has been updated
    Given a permission has been removed from a function's resource policy
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function is created then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a function has been created
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a pending function resolves its deployment then a synchronous function invocation completes
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a pending function has resolved its deployment
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an active function is deleted then a function is invoked asynchronously
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given an active function has been deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a failed function is deleted then an async invocation succeeds
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a failed function has been deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function finishes being deleted then an async invocation fails and is retried
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a function has finished being deleted
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function's code is updated then an async invocation exhausts all retries
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a function's code has been updated
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function's configuration is updated then an event source mapping is created
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a function's configuration has been updated
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function is invoked synchronously without a concurrency limit then an event source mapping finishes creating
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a function has been invoked synchronously without a concurrency limit
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function is invoked synchronously within its concurrency limit then a disabled event source mapping is enabled
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a function has been invoked synchronously within its concurrency limit
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a synchronous function invocation completes then an enabled event source mapping is disabled
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a synchronous function invocation has completed
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a function is invoked asynchronously then an enabled event source mapping is deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a function has been invoked asynchronously
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an async invocation succeeds then a disabled event source mapping is deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given an async invocation has succeeded
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an async invocation fails and is retried then an event source mapping finishes being deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given an async invocation has failed and been retried
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an async invocation exhausts all retries then a tag is added to a function
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given an async invocation has exhausted all retries
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an event source mapping is created then a tag is removed from a function
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given an event source mapping has been created
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an event source mapping finishes creating then a permission is added to a function's resource policy
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given an event source mapping has finished creating
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a disabled event source mapping is enabled then a permission is removed from a function's resource policy
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a disabled event source mapping has been enabled
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an enabled event source mapping is disabled then a function is created
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given an enabled event source mapping has been disabled
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an enabled event source mapping is deleted then a pending function resolves its deployment
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given an enabled event source mapping has been deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a disabled event source mapping is deleted then an active function is deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a disabled event source mapping has been deleted
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then an event source mapping finishes being deleted then a failed function is deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given an event source mapping has finished being deleted
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a tag is added to a function then a function finishes being deleted
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a tag has been added to a function
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a tag is removed from a function then a function's code is updated
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a tag has been removed from a function
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a permission is added to a function's resource policy then a function's configuration is updated
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a permission has been added to a function's resource policy
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: reserved concurrency is set for a function then a permission is removed from a function's resource policy then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given reserved concurrency has been set for a function
    Given a permission has been removed from a function's resource policy
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function is created then a synchronous function invocation completes
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a function has been created
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a pending function resolves its deployment then a function is invoked asynchronously
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a pending function has resolved its deployment
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an active function is deleted then an async invocation succeeds
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given an active function has been deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a failed function is deleted then an async invocation fails and is retried
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a failed function has been deleted
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function finishes being deleted then an async invocation exhausts all retries
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a function has finished being deleted
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function's code is updated then an event source mapping is created
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a function's code has been updated
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function's configuration is updated then an event source mapping finishes creating
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a function's configuration has been updated
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then reserved concurrency is set for a function then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given reserved concurrency has been set for a function
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function is invoked synchronously within its concurrency limit then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a function has been invoked synchronously within its concurrency limit
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a synchronous function invocation completes then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a synchronous function invocation has completed
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a function is invoked asynchronously then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a function has been invoked asynchronously
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an async invocation succeeds then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given an async invocation has succeeded
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an async invocation fails and is retried then a tag is added to a function
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given an async invocation has failed and been retried
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an async invocation exhausts all retries then a tag is removed from a function
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given an async invocation has exhausted all retries
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an event source mapping is created then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given an event source mapping has been created
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an event source mapping finishes creating then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given an event source mapping has finished creating
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a disabled event source mapping is enabled then a function is created
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a disabled event source mapping has been enabled
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an enabled event source mapping is disabled then a pending function resolves its deployment
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given an enabled event source mapping has been disabled
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an enabled event source mapping is deleted then an active function is deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given an enabled event source mapping has been deleted
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a disabled event source mapping is deleted then a failed function is deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a disabled event source mapping has been deleted
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then an event source mapping finishes being deleted then a function finishes being deleted
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given an event source mapping has finished being deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a tag is added to a function then a function's code is updated
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a tag has been added to a function
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a tag is removed from a function then a function's configuration is updated
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a tag has been removed from a function
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a permission is added to a function's resource policy then reserved concurrency is set for a function
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a permission has been added to a function's resource policy
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously without a concurrency limit then a permission is removed from a function's resource policy then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a function has been invoked synchronously without a concurrency limit
    Given a permission has been removed from a function's resource policy
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function is created then a function is invoked asynchronously
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a function has been created
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a pending function resolves its deployment then an async invocation succeeds
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a pending function has resolved its deployment
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an active function is deleted then an async invocation fails and is retried
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given an active function has been deleted
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a failed function is deleted then an async invocation exhausts all retries
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a failed function has been deleted
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function finishes being deleted then an event source mapping is created
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a function has finished being deleted
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function's code is updated then an event source mapping finishes creating
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a function's code has been updated
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function's configuration is updated then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a function's configuration has been updated
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then reserved concurrency is set for a function then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given reserved concurrency has been set for a function
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function is invoked synchronously without a concurrency limit then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a function has been invoked synchronously without a concurrency limit
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a synchronous function invocation completes then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a synchronous function invocation has completed
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a function is invoked asynchronously then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a function has been invoked asynchronously
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an async invocation succeeds then a tag is added to a function
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given an async invocation has succeeded
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an async invocation fails and is retried then a tag is removed from a function
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given an async invocation has failed and been retried
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an async invocation exhausts all retries then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given an async invocation has exhausted all retries
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an event source mapping is created then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given an event source mapping has been created
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an event source mapping finishes creating then a function is created
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given an event source mapping has finished creating
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a disabled event source mapping is enabled then a pending function resolves its deployment
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a disabled event source mapping has been enabled
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an enabled event source mapping is disabled then an active function is deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given an enabled event source mapping has been disabled
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an enabled event source mapping is deleted then a failed function is deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given an enabled event source mapping has been deleted
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a disabled event source mapping is deleted then a function finishes being deleted
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a disabled event source mapping has been deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then an event source mapping finishes being deleted then a function's code is updated
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given an event source mapping has finished being deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a tag is added to a function then a function's configuration is updated
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a tag has been added to a function
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a tag is removed from a function then reserved concurrency is set for a function
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a tag has been removed from a function
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a permission is added to a function's resource policy then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a permission has been added to a function's resource policy
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked synchronously within its concurrency limit then a permission is removed from a function's resource policy then a synchronous function invocation completes
    Given fid in func_status
    Given a function has been invoked synchronously within its concurrency limit
    Given a permission has been removed from a function's resource policy
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function is created then an async invocation succeeds
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a function has been created
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a pending function resolves its deployment then an async invocation fails and is retried
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a pending function has resolved its deployment
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an active function is deleted then an async invocation exhausts all retries
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given an active function has been deleted
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a failed function is deleted then an event source mapping is created
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a failed function has been deleted
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function finishes being deleted then an event source mapping finishes creating
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a function has finished being deleted
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function's code is updated then a disabled event source mapping is enabled
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a function's code has been updated
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function's configuration is updated then an enabled event source mapping is disabled
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a function's configuration has been updated
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then reserved concurrency is set for a function then an enabled event source mapping is deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given reserved concurrency has been set for a function
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function is invoked synchronously without a concurrency limit then a disabled event source mapping is deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a function has been invoked synchronously without a concurrency limit
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function is invoked synchronously within its concurrency limit then an event source mapping finishes being deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a function has been invoked synchronously within its concurrency limit
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a function is invoked asynchronously then a tag is added to a function
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a function has been invoked asynchronously
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an async invocation succeeds then a tag is removed from a function
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given an async invocation has succeeded
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an async invocation fails and is retried then a permission is added to a function's resource policy
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given an async invocation has failed and been retried
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an async invocation exhausts all retries then a permission is removed from a function's resource policy
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given an async invocation has exhausted all retries
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an event source mapping is created then a function is created
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given an event source mapping has been created
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an event source mapping finishes creating then a pending function resolves its deployment
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given an event source mapping has finished creating
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a disabled event source mapping is enabled then an active function is deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a disabled event source mapping has been enabled
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an enabled event source mapping is disabled then a failed function is deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given an enabled event source mapping has been disabled
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an enabled event source mapping is deleted then a function finishes being deleted
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given an enabled event source mapping has been deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a disabled event source mapping is deleted then a function's code is updated
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a disabled event source mapping has been deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then an event source mapping finishes being deleted then a function's configuration is updated
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given an event source mapping has finished being deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a tag is added to a function then reserved concurrency is set for a function
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a tag has been added to a function
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a tag is removed from a function then a function is invoked synchronously without a concurrency limit
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a tag has been removed from a function
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a permission is added to a function's resource policy then a function is invoked synchronously within its concurrency limit
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a permission has been added to a function's resource policy
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a synchronous function invocation completes then a permission is removed from a function's resource policy then a function is invoked asynchronously
    Given fid in func_active_execs
    Given a synchronous function invocation has completed
    Given a permission has been removed from a function's resource policy
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function is created then an async invocation fails and is retried
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a function has been created
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a pending function resolves its deployment then an async invocation exhausts all retries
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a pending function has resolved its deployment
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an active function is deleted then an event source mapping is created
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given an active function has been deleted
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a failed function is deleted then an event source mapping finishes creating
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a failed function has been deleted
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function finishes being deleted then a disabled event source mapping is enabled
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a function has finished being deleted
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function's code is updated then an enabled event source mapping is disabled
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a function's code has been updated
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function's configuration is updated then an enabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a function's configuration has been updated
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then reserved concurrency is set for a function then a disabled event source mapping is deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given reserved concurrency has been set for a function
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function is invoked synchronously without a concurrency limit then an event source mapping finishes being deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a function has been invoked synchronously without a concurrency limit
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a function is invoked synchronously within its concurrency limit then a tag is added to a function
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a function has been invoked synchronously within its concurrency limit
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a synchronous function invocation completes then a tag is removed from a function
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a synchronous function invocation has completed
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an async invocation succeeds then a permission is added to a function's resource policy
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given an async invocation has succeeded
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an async invocation fails and is retried then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given an async invocation has failed and been retried
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an async invocation exhausts all retries then a function is created
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given an async invocation has exhausted all retries
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an event source mapping is created then a pending function resolves its deployment
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given an event source mapping has been created
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an event source mapping finishes creating then an active function is deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given an event source mapping has finished creating
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a disabled event source mapping is enabled then a failed function is deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a disabled event source mapping has been enabled
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an enabled event source mapping is disabled then a function finishes being deleted
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given an enabled event source mapping has been disabled
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an enabled event source mapping is deleted then a function's code is updated
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given an enabled event source mapping has been deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a disabled event source mapping is deleted then a function's configuration is updated
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a disabled event source mapping has been deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then an event source mapping finishes being deleted then reserved concurrency is set for a function
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given an event source mapping has finished being deleted
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a tag is added to a function then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a tag has been added to a function
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a tag is removed from a function then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a tag has been removed from a function
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a permission is added to a function's resource policy then a synchronous function invocation completes
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a permission has been added to a function's resource policy
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a function is invoked asynchronously then a permission is removed from a function's resource policy then an async invocation succeeds
    Given fid in func_status
    Given a function has been invoked asynchronously
    Given a permission has been removed from a function's resource policy
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function is created then an async invocation exhausts all retries
    Given slot in async_func
    Given an async invocation has succeeded
    Given a function has been created
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a pending function resolves its deployment then an event source mapping is created
    Given slot in async_func
    Given an async invocation has succeeded
    Given a pending function has resolved its deployment
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an active function is deleted then an event source mapping finishes creating
    Given slot in async_func
    Given an async invocation has succeeded
    Given an active function has been deleted
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a failed function is deleted then a disabled event source mapping is enabled
    Given slot in async_func
    Given an async invocation has succeeded
    Given a failed function has been deleted
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function finishes being deleted then an enabled event source mapping is disabled
    Given slot in async_func
    Given an async invocation has succeeded
    Given a function has finished being deleted
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function's code is updated then an enabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has succeeded
    Given a function's code has been updated
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function's configuration is updated then a disabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has succeeded
    Given a function's configuration has been updated
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then reserved concurrency is set for a function then an event source mapping finishes being deleted
    Given slot in async_func
    Given an async invocation has succeeded
    Given reserved concurrency has been set for a function
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function is invoked synchronously without a concurrency limit then a tag is added to a function
    Given slot in async_func
    Given an async invocation has succeeded
    Given a function has been invoked synchronously without a concurrency limit
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function is invoked synchronously within its concurrency limit then a tag is removed from a function
    Given slot in async_func
    Given an async invocation has succeeded
    Given a function has been invoked synchronously within its concurrency limit
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a synchronous function invocation completes then a permission is added to a function's resource policy
    Given slot in async_func
    Given an async invocation has succeeded
    Given a synchronous function invocation has completed
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a function is invoked asynchronously then a permission is removed from a function's resource policy
    Given slot in async_func
    Given an async invocation has succeeded
    Given a function has been invoked asynchronously
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an async invocation fails and is retried then a function is created
    Given slot in async_func
    Given an async invocation has succeeded
    Given an async invocation has failed and been retried
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an async invocation exhausts all retries then a pending function resolves its deployment
    Given slot in async_func
    Given an async invocation has succeeded
    Given an async invocation has exhausted all retries
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an event source mapping is created then an active function is deleted
    Given slot in async_func
    Given an async invocation has succeeded
    Given an event source mapping has been created
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an event source mapping finishes creating then a failed function is deleted
    Given slot in async_func
    Given an async invocation has succeeded
    Given an event source mapping has finished creating
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a disabled event source mapping is enabled then a function finishes being deleted
    Given slot in async_func
    Given an async invocation has succeeded
    Given a disabled event source mapping has been enabled
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an enabled event source mapping is disabled then a function's code is updated
    Given slot in async_func
    Given an async invocation has succeeded
    Given an enabled event source mapping has been disabled
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an enabled event source mapping is deleted then a function's configuration is updated
    Given slot in async_func
    Given an async invocation has succeeded
    Given an enabled event source mapping has been deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a disabled event source mapping is deleted then reserved concurrency is set for a function
    Given slot in async_func
    Given an async invocation has succeeded
    Given a disabled event source mapping has been deleted
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then an event source mapping finishes being deleted then a function is invoked synchronously without a concurrency limit
    Given slot in async_func
    Given an async invocation has succeeded
    Given an event source mapping has finished being deleted
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a tag is added to a function then a function is invoked synchronously within its concurrency limit
    Given slot in async_func
    Given an async invocation has succeeded
    Given a tag has been added to a function
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a tag is removed from a function then a synchronous function invocation completes
    Given slot in async_func
    Given an async invocation has succeeded
    Given a tag has been removed from a function
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a permission is added to a function's resource policy then a function is invoked asynchronously
    Given slot in async_func
    Given an async invocation has succeeded
    Given a permission has been added to a function's resource policy
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation succeeds then a permission is removed from a function's resource policy then an async invocation fails and is retried
    Given slot in async_func
    Given an async invocation has succeeded
    Given a permission has been removed from a function's resource policy
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function is created then an event source mapping is created
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a function has been created
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a pending function resolves its deployment then an event source mapping finishes creating
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a pending function has resolved its deployment
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an active function is deleted then a disabled event source mapping is enabled
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given an active function has been deleted
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a failed function is deleted then an enabled event source mapping is disabled
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a failed function has been deleted
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function finishes being deleted then an enabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a function has finished being deleted
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function's code is updated then a disabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a function's code has been updated
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function's configuration is updated then an event source mapping finishes being deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a function's configuration has been updated
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then reserved concurrency is set for a function then a tag is added to a function
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given reserved concurrency has been set for a function
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function is invoked synchronously without a concurrency limit then a tag is removed from a function
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a function has been invoked synchronously without a concurrency limit
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function is invoked synchronously within its concurrency limit then a permission is added to a function's resource policy
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a function has been invoked synchronously within its concurrency limit
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a synchronous function invocation completes then a permission is removed from a function's resource policy
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a synchronous function invocation has completed
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a function is invoked asynchronously then a function is created
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a function has been invoked asynchronously
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an async invocation succeeds then a pending function resolves its deployment
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given an async invocation has succeeded
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an async invocation exhausts all retries then an active function is deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given an async invocation has exhausted all retries
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an event source mapping is created then a failed function is deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given an event source mapping has been created
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an event source mapping finishes creating then a function finishes being deleted
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given an event source mapping has finished creating
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a disabled event source mapping is enabled then a function's code is updated
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a disabled event source mapping has been enabled
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an enabled event source mapping is disabled then a function's configuration is updated
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given an enabled event source mapping has been disabled
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an enabled event source mapping is deleted then reserved concurrency is set for a function
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given an enabled event source mapping has been deleted
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a disabled event source mapping is deleted then a function is invoked synchronously without a concurrency limit
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a disabled event source mapping has been deleted
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then an event source mapping finishes being deleted then a function is invoked synchronously within its concurrency limit
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given an event source mapping has finished being deleted
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a tag is added to a function then a synchronous function invocation completes
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a tag has been added to a function
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a tag is removed from a function then a function is invoked asynchronously
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a tag has been removed from a function
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a permission is added to a function's resource policy then an async invocation succeeds
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a permission has been added to a function's resource policy
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation fails and is retried then a permission is removed from a function's resource policy then an async invocation exhausts all retries
    Given slot in async_func
    Given an async invocation has failed and been retried
    Given a permission has been removed from a function's resource policy
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function is created then an event source mapping finishes creating
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a function has been created
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a pending function resolves its deployment then a disabled event source mapping is enabled
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a pending function has resolved its deployment
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an active function is deleted then an enabled event source mapping is disabled
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given an active function has been deleted
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a failed function is deleted then an enabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a failed function has been deleted
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function finishes being deleted then a disabled event source mapping is deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a function has finished being deleted
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function's code is updated then an event source mapping finishes being deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a function's code has been updated
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function's configuration is updated then a tag is added to a function
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a function's configuration has been updated
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then reserved concurrency is set for a function then a tag is removed from a function
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given reserved concurrency has been set for a function
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function is invoked synchronously without a concurrency limit then a permission is added to a function's resource policy
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a function has been invoked synchronously without a concurrency limit
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function is invoked synchronously within its concurrency limit then a permission is removed from a function's resource policy
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a function has been invoked synchronously within its concurrency limit
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a synchronous function invocation completes then a function is created
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a synchronous function invocation has completed
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a function is invoked asynchronously then a pending function resolves its deployment
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a function has been invoked asynchronously
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an async invocation succeeds then an active function is deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given an async invocation has succeeded
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an async invocation fails and is retried then a failed function is deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given an async invocation has failed and been retried
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an event source mapping is created then a function finishes being deleted
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given an event source mapping has been created
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an event source mapping finishes creating then a function's code is updated
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given an event source mapping has finished creating
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a disabled event source mapping is enabled then a function's configuration is updated
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a disabled event source mapping has been enabled
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an enabled event source mapping is disabled then reserved concurrency is set for a function
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given an enabled event source mapping has been disabled
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an enabled event source mapping is deleted then a function is invoked synchronously without a concurrency limit
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given an enabled event source mapping has been deleted
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a disabled event source mapping is deleted then a function is invoked synchronously within its concurrency limit
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a disabled event source mapping has been deleted
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then an event source mapping finishes being deleted then a synchronous function invocation completes
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given an event source mapping has finished being deleted
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a tag is added to a function then a function is invoked asynchronously
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a tag has been added to a function
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a tag is removed from a function then an async invocation succeeds
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a tag has been removed from a function
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a permission is added to a function's resource policy then an async invocation fails and is retried
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a permission has been added to a function's resource policy
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an async invocation exhausts all retries then a permission is removed from a function's resource policy then an event source mapping is created
    Given slot in async_func
    Given an async invocation has exhausted all retries
    Given a permission has been removed from a function's resource policy
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function is created then a disabled event source mapping is enabled
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a function has been created
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a pending function resolves its deployment then an enabled event source mapping is disabled
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a pending function has resolved its deployment
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an active function is deleted then an enabled event source mapping is deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given an active function has been deleted
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a failed function is deleted then a disabled event source mapping is deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a failed function has been deleted
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function finishes being deleted then an event source mapping finishes being deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a function has finished being deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function's code is updated then a tag is added to a function
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a function's code has been updated
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function's configuration is updated then a tag is removed from a function
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a function's configuration has been updated
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then reserved concurrency is set for a function then a permission is added to a function's resource policy
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given reserved concurrency has been set for a function
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function is invoked synchronously without a concurrency limit then a permission is removed from a function's resource policy
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a function has been invoked synchronously without a concurrency limit
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function is invoked synchronously within its concurrency limit then a function is created
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a function has been invoked synchronously within its concurrency limit
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a synchronous function invocation completes then a pending function resolves its deployment
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a synchronous function invocation has completed
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a function is invoked asynchronously then an active function is deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a function has been invoked asynchronously
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an async invocation succeeds then a failed function is deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given an async invocation has succeeded
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an async invocation fails and is retried then a function finishes being deleted
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given an async invocation has failed and been retried
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an async invocation exhausts all retries then a function's code is updated
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given an async invocation has exhausted all retries
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an event source mapping finishes creating then a function's configuration is updated
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given an event source mapping has finished creating
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a disabled event source mapping is enabled then reserved concurrency is set for a function
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a disabled event source mapping has been enabled
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an enabled event source mapping is disabled then a function is invoked synchronously without a concurrency limit
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given an enabled event source mapping has been disabled
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an enabled event source mapping is deleted then a function is invoked synchronously within its concurrency limit
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given an enabled event source mapping has been deleted
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a disabled event source mapping is deleted then a synchronous function invocation completes
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a disabled event source mapping has been deleted
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then an event source mapping finishes being deleted then a function is invoked asynchronously
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given an event source mapping has finished being deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a tag is added to a function then an async invocation succeeds
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a tag has been added to a function
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a tag is removed from a function then an async invocation fails and is retried
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a tag has been removed from a function
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a permission is added to a function's resource policy then an async invocation exhausts all retries
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a permission has been added to a function's resource policy
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping is created then a permission is removed from a function's resource policy then an event source mapping finishes creating
    Given mid not in mapping_status
    Given an event source mapping has been created
    Given a permission has been removed from a function's resource policy
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function is created then an enabled event source mapping is disabled
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a function has been created
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a pending function resolves its deployment then an enabled event source mapping is deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a pending function has resolved its deployment
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an active function is deleted then a disabled event source mapping is deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given an active function has been deleted
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a failed function is deleted then an event source mapping finishes being deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a failed function has been deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function finishes being deleted then a tag is added to a function
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a function has finished being deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function's code is updated then a tag is removed from a function
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a function's code has been updated
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function's configuration is updated then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a function's configuration has been updated
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then reserved concurrency is set for a function then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given reserved concurrency has been set for a function
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function is invoked synchronously without a concurrency limit then a function is created
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a function has been invoked synchronously without a concurrency limit
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function is invoked synchronously within its concurrency limit then a pending function resolves its deployment
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a function has been invoked synchronously within its concurrency limit
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a synchronous function invocation completes then an active function is deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a synchronous function invocation has completed
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a function is invoked asynchronously then a failed function is deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a function has been invoked asynchronously
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an async invocation succeeds then a function finishes being deleted
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given an async invocation has succeeded
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an async invocation fails and is retried then a function's code is updated
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given an async invocation has failed and been retried
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an async invocation exhausts all retries then a function's configuration is updated
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given an async invocation has exhausted all retries
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an event source mapping is created then reserved concurrency is set for a function
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given an event source mapping has been created
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a disabled event source mapping is enabled then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a disabled event source mapping has been enabled
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an enabled event source mapping is disabled then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given an enabled event source mapping has been disabled
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an enabled event source mapping is deleted then a synchronous function invocation completes
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given an enabled event source mapping has been deleted
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a disabled event source mapping is deleted then a function is invoked asynchronously
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a disabled event source mapping has been deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then an event source mapping finishes being deleted then an async invocation succeeds
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given an event source mapping has finished being deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a tag is added to a function then an async invocation fails and is retried
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a tag has been added to a function
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a tag is removed from a function then an async invocation exhausts all retries
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a tag has been removed from a function
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a permission is added to a function's resource policy then an event source mapping is created
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a permission has been added to a function's resource policy
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes creating then a permission is removed from a function's resource policy then a disabled event source mapping is enabled
    Given mid in mapping_status
    Given an event source mapping has finished creating
    Given a permission has been removed from a function's resource policy
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function is created then an enabled event source mapping is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a function has been created
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a pending function resolves its deployment then a disabled event source mapping is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a pending function has resolved its deployment
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an active function is deleted then an event source mapping finishes being deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given an active function has been deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a failed function is deleted then a tag is added to a function
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a failed function has been deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function finishes being deleted then a tag is removed from a function
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a function has finished being deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function's code is updated then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a function's code has been updated
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function's configuration is updated then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a function's configuration has been updated
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then reserved concurrency is set for a function then a function is created
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given reserved concurrency has been set for a function
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function is invoked synchronously without a concurrency limit then a pending function resolves its deployment
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a function has been invoked synchronously without a concurrency limit
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function is invoked synchronously within its concurrency limit then an active function is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a function has been invoked synchronously within its concurrency limit
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a synchronous function invocation completes then a failed function is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a synchronous function invocation has completed
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a function is invoked asynchronously then a function finishes being deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a function has been invoked asynchronously
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an async invocation succeeds then a function's code is updated
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given an async invocation has succeeded
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an async invocation fails and is retried then a function's configuration is updated
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given an async invocation has failed and been retried
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an async invocation exhausts all retries then reserved concurrency is set for a function
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given an async invocation has exhausted all retries
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an event source mapping is created then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given an event source mapping has been created
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an event source mapping finishes creating then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given an event source mapping has finished creating
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an enabled event source mapping is disabled then a synchronous function invocation completes
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given an enabled event source mapping has been disabled
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an enabled event source mapping is deleted then a function is invoked asynchronously
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given an enabled event source mapping has been deleted
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a disabled event source mapping is deleted then an async invocation succeeds
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a disabled event source mapping has been deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then an event source mapping finishes being deleted then an async invocation fails and is retried
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given an event source mapping has finished being deleted
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a tag is added to a function then an async invocation exhausts all retries
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a tag has been added to a function
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a tag is removed from a function then an event source mapping is created
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a tag has been removed from a function
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a permission is added to a function's resource policy then an event source mapping finishes creating
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a permission has been added to a function's resource policy
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is enabled then a permission is removed from a function's resource policy then an enabled event source mapping is disabled
    Given mid in mapping_status
    Given a disabled event source mapping has been enabled
    Given a permission has been removed from a function's resource policy
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function is created then a disabled event source mapping is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a function has been created
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a pending function resolves its deployment then an event source mapping finishes being deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a pending function has resolved its deployment
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an active function is deleted then a tag is added to a function
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given an active function has been deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a failed function is deleted then a tag is removed from a function
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a failed function has been deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function finishes being deleted then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a function has finished being deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function's code is updated then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a function's code has been updated
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function's configuration is updated then a function is created
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a function's configuration has been updated
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then reserved concurrency is set for a function then a pending function resolves its deployment
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given reserved concurrency has been set for a function
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function is invoked synchronously without a concurrency limit then an active function is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a function has been invoked synchronously without a concurrency limit
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function is invoked synchronously within its concurrency limit then a failed function is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a function has been invoked synchronously within its concurrency limit
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a synchronous function invocation completes then a function finishes being deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a synchronous function invocation has completed
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a function is invoked asynchronously then a function's code is updated
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a function has been invoked asynchronously
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an async invocation succeeds then a function's configuration is updated
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given an async invocation has succeeded
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an async invocation fails and is retried then reserved concurrency is set for a function
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given an async invocation has failed and been retried
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an async invocation exhausts all retries then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given an async invocation has exhausted all retries
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an event source mapping is created then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given an event source mapping has been created
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an event source mapping finishes creating then a synchronous function invocation completes
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given an event source mapping has finished creating
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a disabled event source mapping is enabled then a function is invoked asynchronously
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a disabled event source mapping has been enabled
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an enabled event source mapping is deleted then an async invocation succeeds
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given an enabled event source mapping has been deleted
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a disabled event source mapping is deleted then an async invocation fails and is retried
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a disabled event source mapping has been deleted
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then an event source mapping finishes being deleted then an async invocation exhausts all retries
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given an event source mapping has finished being deleted
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a tag is added to a function then an event source mapping is created
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a tag has been added to a function
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a tag is removed from a function then an event source mapping finishes creating
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a tag has been removed from a function
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a permission is added to a function's resource policy then a disabled event source mapping is enabled
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a permission has been added to a function's resource policy
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is disabled then a permission is removed from a function's resource policy then an enabled event source mapping is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been disabled
    Given a permission has been removed from a function's resource policy
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function is created then an event source mapping finishes being deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a function has been created
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a pending function resolves its deployment then a tag is added to a function
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a pending function has resolved its deployment
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an active function is deleted then a tag is removed from a function
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given an active function has been deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a failed function is deleted then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a failed function has been deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function finishes being deleted then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a function has finished being deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function's code is updated then a function is created
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a function's code has been updated
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function's configuration is updated then a pending function resolves its deployment
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a function's configuration has been updated
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then reserved concurrency is set for a function then an active function is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given reserved concurrency has been set for a function
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function is invoked synchronously without a concurrency limit then a failed function is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a function has been invoked synchronously without a concurrency limit
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function is invoked synchronously within its concurrency limit then a function finishes being deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a function has been invoked synchronously within its concurrency limit
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a synchronous function invocation completes then a function's code is updated
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a synchronous function invocation has completed
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a function is invoked asynchronously then a function's configuration is updated
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a function has been invoked asynchronously
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an async invocation succeeds then reserved concurrency is set for a function
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given an async invocation has succeeded
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an async invocation fails and is retried then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given an async invocation has failed and been retried
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an async invocation exhausts all retries then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given an async invocation has exhausted all retries
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an event source mapping is created then a synchronous function invocation completes
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given an event source mapping has been created
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an event source mapping finishes creating then a function is invoked asynchronously
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given an event source mapping has finished creating
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a disabled event source mapping is enabled then an async invocation succeeds
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a disabled event source mapping has been enabled
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an enabled event source mapping is disabled then an async invocation fails and is retried
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given an enabled event source mapping has been disabled
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a disabled event source mapping is deleted then an async invocation exhausts all retries
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a disabled event source mapping has been deleted
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then an event source mapping finishes being deleted then an event source mapping is created
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given an event source mapping has finished being deleted
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a tag is added to a function then an event source mapping finishes creating
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a tag has been added to a function
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a tag is removed from a function then a disabled event source mapping is enabled
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a tag has been removed from a function
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a permission is added to a function's resource policy then an enabled event source mapping is disabled
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a permission has been added to a function's resource policy
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an enabled event source mapping is deleted then a permission is removed from a function's resource policy then a disabled event source mapping is deleted
    Given mid in mapping_status
    Given an enabled event source mapping has been deleted
    Given a permission has been removed from a function's resource policy
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function is created then a tag is added to a function
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a function has been created
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a pending function resolves its deployment then a tag is removed from a function
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a pending function has resolved its deployment
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an active function is deleted then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given an active function has been deleted
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a failed function is deleted then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a failed function has been deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function finishes being deleted then a function is created
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a function has finished being deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function's code is updated then a pending function resolves its deployment
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a function's code has been updated
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function's configuration is updated then an active function is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a function's configuration has been updated
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then reserved concurrency is set for a function then a failed function is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given reserved concurrency has been set for a function
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function is invoked synchronously without a concurrency limit then a function finishes being deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a function has been invoked synchronously without a concurrency limit
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function is invoked synchronously within its concurrency limit then a function's code is updated
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a function has been invoked synchronously within its concurrency limit
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a synchronous function invocation completes then a function's configuration is updated
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a synchronous function invocation has completed
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a function is invoked asynchronously then reserved concurrency is set for a function
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a function has been invoked asynchronously
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an async invocation succeeds then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given an async invocation has succeeded
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an async invocation fails and is retried then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given an async invocation has failed and been retried
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an async invocation exhausts all retries then a synchronous function invocation completes
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given an async invocation has exhausted all retries
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an event source mapping is created then a function is invoked asynchronously
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given an event source mapping has been created
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an event source mapping finishes creating then an async invocation succeeds
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given an event source mapping has finished creating
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a disabled event source mapping is enabled then an async invocation fails and is retried
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a disabled event source mapping has been enabled
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an enabled event source mapping is disabled then an async invocation exhausts all retries
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given an enabled event source mapping has been disabled
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an enabled event source mapping is deleted then an event source mapping is created
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given an enabled event source mapping has been deleted
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then an event source mapping finishes being deleted then an event source mapping finishes creating
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given an event source mapping has finished being deleted
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a tag is added to a function then a disabled event source mapping is enabled
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a tag has been added to a function
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a tag is removed from a function then an enabled event source mapping is disabled
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a tag has been removed from a function
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a permission is added to a function's resource policy then an enabled event source mapping is deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a permission has been added to a function's resource policy
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a disabled event source mapping is deleted then a permission is removed from a function's resource policy then an event source mapping finishes being deleted
    Given mid in mapping_status
    Given a disabled event source mapping has been deleted
    Given a permission has been removed from a function's resource policy
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function is created then a tag is removed from a function
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a function has been created
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a pending function resolves its deployment then a permission is added to a function's resource policy
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a pending function has resolved its deployment
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an active function is deleted then a permission is removed from a function's resource policy
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given an active function has been deleted
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a failed function is deleted then a function is created
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a failed function has been deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function finishes being deleted then a pending function resolves its deployment
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a function has finished being deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function's code is updated then an active function is deleted
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a function's code has been updated
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function's configuration is updated then a failed function is deleted
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a function's configuration has been updated
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then reserved concurrency is set for a function then a function finishes being deleted
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given reserved concurrency has been set for a function
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function is invoked synchronously without a concurrency limit then a function's code is updated
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a function has been invoked synchronously without a concurrency limit
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function is invoked synchronously within its concurrency limit then a function's configuration is updated
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a function has been invoked synchronously within its concurrency limit
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a synchronous function invocation completes then reserved concurrency is set for a function
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a synchronous function invocation has completed
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a function is invoked asynchronously then a function is invoked synchronously without a concurrency limit
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a function has been invoked asynchronously
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an async invocation succeeds then a function is invoked synchronously within its concurrency limit
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given an async invocation has succeeded
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an async invocation fails and is retried then a synchronous function invocation completes
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given an async invocation has failed and been retried
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an async invocation exhausts all retries then a function is invoked asynchronously
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given an async invocation has exhausted all retries
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an event source mapping is created then an async invocation succeeds
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given an event source mapping has been created
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an event source mapping finishes creating then an async invocation fails and is retried
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given an event source mapping has finished creating
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a disabled event source mapping is enabled then an async invocation exhausts all retries
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a disabled event source mapping has been enabled
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an enabled event source mapping is disabled then an event source mapping is created
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given an enabled event source mapping has been disabled
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then an enabled event source mapping is deleted then an event source mapping finishes creating
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given an enabled event source mapping has been deleted
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a disabled event source mapping is deleted then a disabled event source mapping is enabled
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a disabled event source mapping has been deleted
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a tag is added to a function then an enabled event source mapping is disabled
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a tag has been added to a function
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a tag is removed from a function then an enabled event source mapping is deleted
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a tag has been removed from a function
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a permission is added to a function's resource policy then a disabled event source mapping is deleted
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a permission has been added to a function's resource policy
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: an event source mapping finishes being deleted then a permission is removed from a function's resource policy then a tag is added to a function
    Given mid in mapping_status
    Given an event source mapping has finished being deleted
    Given a permission has been removed from a function's resource policy
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function is created then a permission is added to a function's resource policy
    Given fid in func_status
    Given a tag has been added to a function
    Given a function has been created
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a pending function resolves its deployment then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a tag has been added to a function
    Given a pending function has resolved its deployment
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an active function is deleted then a function is created
    Given fid in func_status
    Given a tag has been added to a function
    Given an active function has been deleted
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a failed function is deleted then a pending function resolves its deployment
    Given fid in func_status
    Given a tag has been added to a function
    Given a failed function has been deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function finishes being deleted then an active function is deleted
    Given fid in func_status
    Given a tag has been added to a function
    Given a function has finished being deleted
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function's code is updated then a failed function is deleted
    Given fid in func_status
    Given a tag has been added to a function
    Given a function's code has been updated
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function's configuration is updated then a function finishes being deleted
    Given fid in func_status
    Given a tag has been added to a function
    Given a function's configuration has been updated
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then reserved concurrency is set for a function then a function's code is updated
    Given fid in func_status
    Given a tag has been added to a function
    Given reserved concurrency has been set for a function
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function is invoked synchronously without a concurrency limit then a function's configuration is updated
    Given fid in func_status
    Given a tag has been added to a function
    Given a function has been invoked synchronously without a concurrency limit
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function is invoked synchronously within its concurrency limit then reserved concurrency is set for a function
    Given fid in func_status
    Given a tag has been added to a function
    Given a function has been invoked synchronously within its concurrency limit
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a synchronous function invocation completes then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a tag has been added to a function
    Given a synchronous function invocation has completed
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a function is invoked asynchronously then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a tag has been added to a function
    Given a function has been invoked asynchronously
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an async invocation succeeds then a synchronous function invocation completes
    Given fid in func_status
    Given a tag has been added to a function
    Given an async invocation has succeeded
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an async invocation fails and is retried then a function is invoked asynchronously
    Given fid in func_status
    Given a tag has been added to a function
    Given an async invocation has failed and been retried
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an async invocation exhausts all retries then an async invocation succeeds
    Given fid in func_status
    Given a tag has been added to a function
    Given an async invocation has exhausted all retries
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an event source mapping is created then an async invocation fails and is retried
    Given fid in func_status
    Given a tag has been added to a function
    Given an event source mapping has been created
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an event source mapping finishes creating then an async invocation exhausts all retries
    Given fid in func_status
    Given a tag has been added to a function
    Given an event source mapping has finished creating
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a disabled event source mapping is enabled then an event source mapping is created
    Given fid in func_status
    Given a tag has been added to a function
    Given a disabled event source mapping has been enabled
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an enabled event source mapping is disabled then an event source mapping finishes creating
    Given fid in func_status
    Given a tag has been added to a function
    Given an enabled event source mapping has been disabled
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an enabled event source mapping is deleted then a disabled event source mapping is enabled
    Given fid in func_status
    Given a tag has been added to a function
    Given an enabled event source mapping has been deleted
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a disabled event source mapping is deleted then an enabled event source mapping is disabled
    Given fid in func_status
    Given a tag has been added to a function
    Given a disabled event source mapping has been deleted
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then an event source mapping finishes being deleted then an enabled event source mapping is deleted
    Given fid in func_status
    Given a tag has been added to a function
    Given an event source mapping has finished being deleted
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a tag is removed from a function then a disabled event source mapping is deleted
    Given fid in func_status
    Given a tag has been added to a function
    Given a tag has been removed from a function
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a permission is added to a function's resource policy then an event source mapping finishes being deleted
    Given fid in func_status
    Given a tag has been added to a function
    Given a permission has been added to a function's resource policy
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is added to a function then a permission is removed from a function's resource policy then a tag is removed from a function
    Given fid in func_status
    Given a tag has been added to a function
    Given a permission has been removed from a function's resource policy
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function is created then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a tag has been removed from a function
    Given a function has been created
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a pending function resolves its deployment then a function is created
    Given fid in func_status
    Given a tag has been removed from a function
    Given a pending function has resolved its deployment
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an active function is deleted then a pending function resolves its deployment
    Given fid in func_status
    Given a tag has been removed from a function
    Given an active function has been deleted
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a failed function is deleted then an active function is deleted
    Given fid in func_status
    Given a tag has been removed from a function
    Given a failed function has been deleted
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function finishes being deleted then a failed function is deleted
    Given fid in func_status
    Given a tag has been removed from a function
    Given a function has finished being deleted
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function's code is updated then a function finishes being deleted
    Given fid in func_status
    Given a tag has been removed from a function
    Given a function's code has been updated
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function's configuration is updated then a function's code is updated
    Given fid in func_status
    Given a tag has been removed from a function
    Given a function's configuration has been updated
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then reserved concurrency is set for a function then a function's configuration is updated
    Given fid in func_status
    Given a tag has been removed from a function
    Given reserved concurrency has been set for a function
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function is invoked synchronously without a concurrency limit then reserved concurrency is set for a function
    Given fid in func_status
    Given a tag has been removed from a function
    Given a function has been invoked synchronously without a concurrency limit
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function is invoked synchronously within its concurrency limit then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a tag has been removed from a function
    Given a function has been invoked synchronously within its concurrency limit
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a synchronous function invocation completes then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a tag has been removed from a function
    Given a synchronous function invocation has completed
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a function is invoked asynchronously then a synchronous function invocation completes
    Given fid in func_status
    Given a tag has been removed from a function
    Given a function has been invoked asynchronously
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an async invocation succeeds then a function is invoked asynchronously
    Given fid in func_status
    Given a tag has been removed from a function
    Given an async invocation has succeeded
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an async invocation fails and is retried then an async invocation succeeds
    Given fid in func_status
    Given a tag has been removed from a function
    Given an async invocation has failed and been retried
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an async invocation exhausts all retries then an async invocation fails and is retried
    Given fid in func_status
    Given a tag has been removed from a function
    Given an async invocation has exhausted all retries
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an event source mapping is created then an async invocation exhausts all retries
    Given fid in func_status
    Given a tag has been removed from a function
    Given an event source mapping has been created
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an event source mapping finishes creating then an event source mapping is created
    Given fid in func_status
    Given a tag has been removed from a function
    Given an event source mapping has finished creating
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a disabled event source mapping is enabled then an event source mapping finishes creating
    Given fid in func_status
    Given a tag has been removed from a function
    Given a disabled event source mapping has been enabled
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an enabled event source mapping is disabled then a disabled event source mapping is enabled
    Given fid in func_status
    Given a tag has been removed from a function
    Given an enabled event source mapping has been disabled
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an enabled event source mapping is deleted then an enabled event source mapping is disabled
    Given fid in func_status
    Given a tag has been removed from a function
    Given an enabled event source mapping has been deleted
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a disabled event source mapping is deleted then an enabled event source mapping is deleted
    Given fid in func_status
    Given a tag has been removed from a function
    Given a disabled event source mapping has been deleted
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then an event source mapping finishes being deleted then a disabled event source mapping is deleted
    Given fid in func_status
    Given a tag has been removed from a function
    Given an event source mapping has finished being deleted
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a tag is added to a function then an event source mapping finishes being deleted
    Given fid in func_status
    Given a tag has been removed from a function
    Given a tag has been added to a function
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a permission is added to a function's resource policy then a tag is added to a function
    Given fid in func_status
    Given a tag has been removed from a function
    Given a permission has been added to a function's resource policy
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a tag is removed from a function then a permission is removed from a function's resource policy then a permission is added to a function's resource policy
    Given fid in func_status
    Given a tag has been removed from a function
    Given a permission has been removed from a function's resource policy
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function is created then a pending function resolves its deployment
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a function has been created
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a pending function resolves its deployment then an active function is deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a pending function has resolved its deployment
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an active function is deleted then a failed function is deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given an active function has been deleted
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a failed function is deleted then a function finishes being deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a failed function has been deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function finishes being deleted then a function's code is updated
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a function has finished being deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function's code is updated then a function's configuration is updated
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a function's code has been updated
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function's configuration is updated then reserved concurrency is set for a function
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a function's configuration has been updated
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then reserved concurrency is set for a function then a function is invoked synchronously without a concurrency limit
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given reserved concurrency has been set for a function
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function is invoked synchronously without a concurrency limit then a function is invoked synchronously within its concurrency limit
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a function has been invoked synchronously without a concurrency limit
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function is invoked synchronously within its concurrency limit then a synchronous function invocation completes
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a function has been invoked synchronously within its concurrency limit
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a synchronous function invocation completes then a function is invoked asynchronously
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a synchronous function invocation has completed
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a function is invoked asynchronously then an async invocation succeeds
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a function has been invoked asynchronously
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an async invocation succeeds then an async invocation fails and is retried
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given an async invocation has succeeded
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an async invocation fails and is retried then an async invocation exhausts all retries
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given an async invocation has failed and been retried
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an async invocation exhausts all retries then an event source mapping is created
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given an async invocation has exhausted all retries
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an event source mapping is created then an event source mapping finishes creating
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given an event source mapping has been created
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an event source mapping finishes creating then a disabled event source mapping is enabled
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given an event source mapping has finished creating
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a disabled event source mapping is enabled then an enabled event source mapping is disabled
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a disabled event source mapping has been enabled
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an enabled event source mapping is disabled then an enabled event source mapping is deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given an enabled event source mapping has been disabled
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an enabled event source mapping is deleted then a disabled event source mapping is deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given an enabled event source mapping has been deleted
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a disabled event source mapping is deleted then an event source mapping finishes being deleted
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a disabled event source mapping has been deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then an event source mapping finishes being deleted then a tag is added to a function
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given an event source mapping has finished being deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a tag is added to a function then a tag is removed from a function
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a tag has been added to a function
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a tag is removed from a function then a permission is removed from a function's resource policy
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a tag has been removed from a function
    When a permission is removed from a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is added to a function's resource policy then a permission is removed from a function's resource policy then a function is created
    Given fid in func_status
    Given a permission has been added to a function's resource policy
    Given a permission has been removed from a function's resource policy
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function is created then an active function is deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a function has been created
    When an active function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a pending function resolves its deployment then a failed function is deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a pending function has resolved its deployment
    When a failed function is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an active function is deleted then a function finishes being deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given an active function has been deleted
    When a function finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a failed function is deleted then a function's code is updated
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a failed function has been deleted
    When a function's code is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function finishes being deleted then a function's configuration is updated
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a function has finished being deleted
    When a function's configuration is updated
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function's code is updated then reserved concurrency is set for a function
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a function's code has been updated
    When reserved concurrency is set for a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function's configuration is updated then a function is invoked synchronously without a concurrency limit
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a function's configuration has been updated
    When a function is invoked synchronously without a concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then reserved concurrency is set for a function then a function is invoked synchronously within its concurrency limit
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given reserved concurrency has been set for a function
    When a function is invoked synchronously within its concurrency limit
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function is invoked synchronously without a concurrency limit then a synchronous function invocation completes
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a function has been invoked synchronously without a concurrency limit
    When a synchronous function invocation completes
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function is invoked synchronously within its concurrency limit then a function is invoked asynchronously
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a function has been invoked synchronously within its concurrency limit
    When a function is invoked asynchronously
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a synchronous function invocation completes then an async invocation succeeds
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a synchronous function invocation has completed
    When an async invocation succeeds
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a function is invoked asynchronously then an async invocation fails and is retried
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a function has been invoked asynchronously
    When an async invocation fails and is retried
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an async invocation succeeds then an async invocation exhausts all retries
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given an async invocation has succeeded
    When an async invocation exhausts all retries
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an async invocation fails and is retried then an event source mapping is created
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given an async invocation has failed and been retried
    When an event source mapping is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an async invocation exhausts all retries then an event source mapping finishes creating
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given an async invocation has exhausted all retries
    When an event source mapping finishes creating
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an event source mapping is created then a disabled event source mapping is enabled
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given an event source mapping has been created
    When a disabled event source mapping is enabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an event source mapping finishes creating then an enabled event source mapping is disabled
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given an event source mapping has finished creating
    When an enabled event source mapping is disabled
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a disabled event source mapping is enabled then an enabled event source mapping is deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a disabled event source mapping has been enabled
    When an enabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an enabled event source mapping is disabled then a disabled event source mapping is deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given an enabled event source mapping has been disabled
    When a disabled event source mapping is deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an enabled event source mapping is deleted then an event source mapping finishes being deleted
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given an enabled event source mapping has been deleted
    When an event source mapping finishes being deleted
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a disabled event source mapping is deleted then a tag is added to a function
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a disabled event source mapping has been deleted
    When a tag is added to a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then an event source mapping finishes being deleted then a tag is removed from a function
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given an event source mapping has finished being deleted
    When a tag is removed from a function
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a tag is added to a function then a permission is added to a function's resource policy
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a tag has been added to a function
    When a permission is added to a function's resource policy
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a tag is removed from a function then a function is created
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a tag has been removed from a function
    When a function is created
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty

  @exhaustive @sequence
  Scenario: a permission is removed from a function's resource policy then a permission is added to a function's resource policy then a pending function resolves its deployment
    Given fid in func_has_policy
    Given a permission has been removed from a function's resource policy
    Given a permission has been added to a function's resource policy
    When a pending function resolves its deployment
    Then every active event source mapping references an existing non-deleted function
    And no function in "DELETING" state has active executions
    And active execution count never exceeds reserved concurrency when set
    And async retry count never exceeds two
    And every event source mapping has a valid status
    And every function has a valid status
    And all async slots reference known function IDs or are empty
