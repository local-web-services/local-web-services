@lambdaevents @generated
Feature: LambdaEvents - Action Sequences

  # Generated from FizzBee spec: lambda_events.fizz
  # Safety invariants: InvocationRequiresActiveFunction, PublishedEventReferencesExistingBus

  Background:
    Given the system is initialized

  @sequence
  Scenario: a "lambda" "function" is deployed then an "eventbridge" "bus" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "eventbridge" "bus" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "eventbridge" "bus" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to publish because the event bus has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "lambda" "function" is deployed
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "lambda" "function" is invoked
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "lambda" "function" fails to publish because the event bus has been deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "lambda" "function" fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "lambda" "function" is deployed
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "lambda" "function" is invoked
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "lambda" "function" fails to publish because the event bus has been deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "lambda" "function" fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then an "eventbridge" "bus" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "eventbridge" "bus" is deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "eventbridge" "bus" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to publish because the event bus has been deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then an "eventbridge" "bus" is created
    Given iid in inv_status
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then the "eventbridge" "bus" is deleted
    Given iid in inv_status
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When the "eventbridge" "bus" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then the "lambda" "function" fails to publish because the event bus has been deleted
    Given iid in inv_status
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When the "lambda" "function" fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted then an "eventbridge" "bus" is created
    Given iid in inv_status
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted then the "eventbridge" "bus" is deleted
    Given iid in inv_status
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When the "eventbridge" "bus" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "eventbridge" "bus" is deleted then the "lambda" "function" is invoked
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "eventbridge" "bus" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" is invoked then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then the "lambda" "function" fails to publish because the event bus has been deleted
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When the "lambda" "function" fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: a "lambda" "function" is deployed then the "lambda" "function" fails to publish because the event bus has been deleted then an "eventbridge" "bus" is created
    Given fid not in func_status
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then a "lambda" "function" is deployed then the "lambda" "function" is invoked
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When a "lambda" "function" is deployed
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "lambda" "function" is invoked then the "lambda" "function" fails to publish because the event bus has been deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then a "lambda" "function" is deployed
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: an "eventbridge" "bus" is created then the "lambda" "function" fails to publish because the event bus has been deleted then the "eventbridge" "bus" is deleted
    Given busid not in bus_status
    When an "eventbridge" "bus" is created
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When the "eventbridge" "bus" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then a "lambda" "function" is deployed then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When a "lambda" "function" is deployed
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created then the "lambda" "function" fails to publish because the event bus has been deleted
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    When the "lambda" "function" fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then an "eventbridge" "bus" is created
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "eventbridge" "bus" is deleted then the "lambda" "function" fails to publish because the event bus has been deleted then the "lambda" "function" is invoked
    Given busid in bus_status
    When the "eventbridge" "bus" is deleted
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then a "lambda" "function" is deployed then the "lambda" "function" fails to publish because the event bus has been deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    When the "lambda" "function" fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then an "eventbridge" "bus" is created then a "lambda" "function" is deployed
    Given fid in func_status
    When the "lambda" "function" is invoked
    When an "eventbridge" "bus" is created
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "eventbridge" "bus" is deleted then an "eventbridge" "bus" is created
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "eventbridge" "bus" is deleted
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then the "eventbridge" "bus" is deleted
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When the "eventbridge" "bus" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" is invoked then the "lambda" "function" fails to publish because the event bus has been deleted then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Given fid in func_status
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then a "lambda" "function" is deployed then an "eventbridge" "bus" is created
    Given iid in inv_status
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When a "lambda" "function" is deployed
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then an "eventbridge" "bus" is created then the "eventbridge" "bus" is deleted
    Given iid in inv_status
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When an "eventbridge" "bus" is created
    When the "eventbridge" "bus" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then the "eventbridge" "bus" is deleted then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When the "eventbridge" "bus" is deleted
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then the "lambda" "function" is invoked then the "lambda" "function" fails to publish because the event bus has been deleted
    Given iid in inv_status
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When the "lambda" "function" is invoked
    When the "lambda" "function" fails to publish because the event bus has been deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then the "lambda" "function" fails to publish because the event bus has been deleted then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted then a "lambda" "function" is deployed then the "eventbridge" "bus" is deleted
    Given iid in inv_status
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When a "lambda" "function" is deployed
    When the "eventbridge" "bus" is deleted
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted then an "eventbridge" "bus" is created then the "lambda" "function" is invoked
    Given iid in inv_status
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When an "eventbridge" "bus" is created
    When the "lambda" "function" is invoked
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted then the "eventbridge" "bus" is deleted then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    Given iid in inv_status
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When the "eventbridge" "bus" is deleted
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted then the "lambda" "function" is invoked then a "lambda" "function" is deployed
    Given iid in inv_status
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When the "lambda" "function" is invoked
    When a "lambda" "function" is deployed
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists

  @sequence
  Scenario: the "lambda" "function" fails to publish because the event bus has been deleted then the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds then an "eventbridge" "bus" is created
    Given iid in inv_status
    When the "lambda" "function" fails to publish because the event bus has been deleted
    When the "lambda" "function" publishes an event to the "ACTIVE" event bus and succeeds
    When an "eventbridge" "bus" is created
    And every "IN_PROGRESS" "lambda" "function" invocation references an "ACTIVE" "lambda" "function"
    And every "PUBLISHED" "eventbridge" "event" references a "eventbridge" "bus" that exists
