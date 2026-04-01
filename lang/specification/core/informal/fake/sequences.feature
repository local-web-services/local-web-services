@fake @generated
Feature: Fake - Action Sequences

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @sequence
  Scenario: a fake server is created then a fake server is deleted
    Given sid not in server_status
    When a fake server is created
    When a fake server is deleted
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is created then a route is added to a fake server
    Given sid not in server_status
    When a fake server is created
    When a route is added to a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is created then a route is removed from a fake server
    Given sid not in server_status
    When a fake server is created
    When a route is removed from a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is created then the status of a fake server is retrieved
    Given sid not in server_status
    When a fake server is created
    When the status of a fake server is retrieved
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is created then chaos was "ENABLED" or disabled for a fake server
    Given sid not in server_status
    When a fake server is created
    When chaos was "ENABLED" or disabled for a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is deleted then a fake server is created
    Given sid in server_status
    When a fake server is deleted
    When a fake server is created
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is deleted then a route is added to a fake server
    Given sid in server_status
    When a fake server is deleted
    When a route is added to a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is deleted then a route is removed from a fake server
    Given sid in server_status
    When a fake server is deleted
    When a route is removed from a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is deleted then the status of a fake server is retrieved
    Given sid in server_status
    When a fake server is deleted
    When the status of a fake server is retrieved
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is deleted then chaos was "ENABLED" or disabled for a fake server
    Given sid in server_status
    When a fake server is deleted
    When chaos was "ENABLED" or disabled for a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is added to a fake server then a fake server is created
    Given sid in server_status
    When a route is added to a fake server
    When a fake server is created
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is added to a fake server then a fake server is deleted
    Given sid in server_status
    When a route is added to a fake server
    When a fake server is deleted
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is added to a fake server then a route is removed from a fake server
    Given sid in server_status
    When a route is added to a fake server
    When a route is removed from a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is added to a fake server then the status of a fake server is retrieved
    Given sid in server_status
    When a route is added to a fake server
    When the status of a fake server is retrieved
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is added to a fake server then chaos was "ENABLED" or disabled for a fake server
    Given sid in server_status
    When a route is added to a fake server
    When chaos was "ENABLED" or disabled for a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is removed from a fake server then a fake server is created
    Given rid in route_status
    When a route is removed from a fake server
    When a fake server is created
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is removed from a fake server then a fake server is deleted
    Given rid in route_status
    When a route is removed from a fake server
    When a fake server is deleted
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is removed from a fake server then a route is added to a fake server
    Given rid in route_status
    When a route is removed from a fake server
    When a route is added to a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is removed from a fake server then the status of a fake server is retrieved
    Given rid in route_status
    When a route is removed from a fake server
    When the status of a fake server is retrieved
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is removed from a fake server then chaos was "ENABLED" or disabled for a fake server
    Given rid in route_status
    When a route is removed from a fake server
    When chaos was "ENABLED" or disabled for a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: the status of a fake server is retrieved then a fake server is created
    Given sid in server_status
    When the status of a fake server is retrieved
    When a fake server is created
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: the status of a fake server is retrieved then a fake server is deleted
    Given sid in server_status
    When the status of a fake server is retrieved
    When a fake server is deleted
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: the status of a fake server is retrieved then a route is added to a fake server
    Given sid in server_status
    When the status of a fake server is retrieved
    When a route is added to a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: the status of a fake server is retrieved then a route is removed from a fake server
    Given sid in server_status
    When the status of a fake server is retrieved
    When a route is removed from a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: the status of a fake server is retrieved then chaos was "ENABLED" or disabled for a fake server
    Given sid in server_status
    When the status of a fake server is retrieved
    When chaos was "ENABLED" or disabled for a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: chaos was "ENABLED" or disabled for a fake server then a fake server is created
    Given sid in server_status
    When chaos was "ENABLED" or disabled for a fake server
    When a fake server is created
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: chaos was "ENABLED" or disabled for a fake server then a fake server is deleted
    Given sid in server_status
    When chaos was "ENABLED" or disabled for a fake server
    When a fake server is deleted
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: chaos was "ENABLED" or disabled for a fake server then a route is added to a fake server
    Given sid in server_status
    When chaos was "ENABLED" or disabled for a fake server
    When a route is added to a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: chaos was "ENABLED" or disabled for a fake server then a route is removed from a fake server
    Given sid in server_status
    When chaos was "ENABLED" or disabled for a fake server
    When a route is removed from a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: chaos was "ENABLED" or disabled for a fake server then the status of a fake server is retrieved
    Given sid in server_status
    When chaos was "ENABLED" or disabled for a fake server
    When the status of a fake server is retrieved
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is created then a fake server is deleted then a route is added to a fake server
    Given sid not in server_status
    When a fake server is created
    When a fake server is deleted
    When a route is added to a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is created then a route is added to a fake server then a route is removed from a fake server
    Given sid not in server_status
    When a fake server is created
    When a route is added to a fake server
    When a route is removed from a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is created then a route is removed from a fake server then the status of a fake server is retrieved
    Given sid not in server_status
    When a fake server is created
    When a route is removed from a fake server
    When the status of a fake server is retrieved
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is created then the status of a fake server is retrieved then chaos was "ENABLED" or disabled for a fake server
    Given sid not in server_status
    When a fake server is created
    When the status of a fake server is retrieved
    When chaos was "ENABLED" or disabled for a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is created then chaos was "ENABLED" or disabled for a fake server then a fake server is deleted
    Given sid not in server_status
    When a fake server is created
    When chaos was "ENABLED" or disabled for a fake server
    When a fake server is deleted
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is deleted then a fake server is created then a route is removed from a fake server
    Given sid in server_status
    When a fake server is deleted
    When a fake server is created
    When a route is removed from a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is deleted then a route is added to a fake server then the status of a fake server is retrieved
    Given sid in server_status
    When a fake server is deleted
    When a route is added to a fake server
    When the status of a fake server is retrieved
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is deleted then a route is removed from a fake server then chaos was "ENABLED" or disabled for a fake server
    Given sid in server_status
    When a fake server is deleted
    When a route is removed from a fake server
    When chaos was "ENABLED" or disabled for a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is deleted then the status of a fake server is retrieved then a fake server is created
    Given sid in server_status
    When a fake server is deleted
    When the status of a fake server is retrieved
    When a fake server is created
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a fake server is deleted then chaos was "ENABLED" or disabled for a fake server then a route is added to a fake server
    Given sid in server_status
    When a fake server is deleted
    When chaos was "ENABLED" or disabled for a fake server
    When a route is added to a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is added to a fake server then a fake server is created then the status of a fake server is retrieved
    Given sid in server_status
    When a route is added to a fake server
    When a fake server is created
    When the status of a fake server is retrieved
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is added to a fake server then a fake server is deleted then chaos was "ENABLED" or disabled for a fake server
    Given sid in server_status
    When a route is added to a fake server
    When a fake server is deleted
    When chaos was "ENABLED" or disabled for a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is added to a fake server then a route is removed from a fake server then a fake server is created
    Given sid in server_status
    When a route is added to a fake server
    When a route is removed from a fake server
    When a fake server is created
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is added to a fake server then the status of a fake server is retrieved then a fake server is deleted
    Given sid in server_status
    When a route is added to a fake server
    When the status of a fake server is retrieved
    When a fake server is deleted
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is added to a fake server then chaos was "ENABLED" or disabled for a fake server then a route is removed from a fake server
    Given sid in server_status
    When a route is added to a fake server
    When chaos was "ENABLED" or disabled for a fake server
    When a route is removed from a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is removed from a fake server then a fake server is created then chaos was "ENABLED" or disabled for a fake server
    Given rid in route_status
    When a route is removed from a fake server
    When a fake server is created
    When chaos was "ENABLED" or disabled for a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is removed from a fake server then a fake server is deleted then a fake server is created
    Given rid in route_status
    When a route is removed from a fake server
    When a fake server is deleted
    When a fake server is created
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is removed from a fake server then a route is added to a fake server then a fake server is deleted
    Given rid in route_status
    When a route is removed from a fake server
    When a route is added to a fake server
    When a fake server is deleted
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is removed from a fake server then the status of a fake server is retrieved then a route is added to a fake server
    Given rid in route_status
    When a route is removed from a fake server
    When the status of a fake server is retrieved
    When a route is added to a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: a route is removed from a fake server then chaos was "ENABLED" or disabled for a fake server then the status of a fake server is retrieved
    Given rid in route_status
    When a route is removed from a fake server
    When chaos was "ENABLED" or disabled for a fake server
    When the status of a fake server is retrieved
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: the status of a fake server is retrieved then a fake server is created then a fake server is deleted
    Given sid in server_status
    When the status of a fake server is retrieved
    When a fake server is created
    When a fake server is deleted
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: the status of a fake server is retrieved then a fake server is deleted then a route is added to a fake server
    Given sid in server_status
    When the status of a fake server is retrieved
    When a fake server is deleted
    When a route is added to a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: the status of a fake server is retrieved then a route is added to a fake server then a route is removed from a fake server
    Given sid in server_status
    When the status of a fake server is retrieved
    When a route is added to a fake server
    When a route is removed from a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: the status of a fake server is retrieved then a route is removed from a fake server then chaos was "ENABLED" or disabled for a fake server
    Given sid in server_status
    When the status of a fake server is retrieved
    When a route is removed from a fake server
    When chaos was "ENABLED" or disabled for a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: the status of a fake server is retrieved then chaos was "ENABLED" or disabled for a fake server then a fake server is created
    Given sid in server_status
    When the status of a fake server is retrieved
    When chaos was "ENABLED" or disabled for a fake server
    When a fake server is created
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: chaos was "ENABLED" or disabled for a fake server then a fake server is created then a route is added to a fake server
    Given sid in server_status
    When chaos was "ENABLED" or disabled for a fake server
    When a fake server is created
    When a route is added to a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: chaos was "ENABLED" or disabled for a fake server then a fake server is deleted then a route is removed from a fake server
    Given sid in server_status
    When chaos was "ENABLED" or disabled for a fake server
    When a fake server is deleted
    When a route is removed from a fake server
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: chaos was "ENABLED" or disabled for a fake server then a route is added to a fake server then the status of a fake server is retrieved
    Given sid in server_status
    When chaos was "ENABLED" or disabled for a fake server
    When a route is added to a fake server
    When the status of a fake server is retrieved
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: chaos was "ENABLED" or disabled for a fake server then a route is removed from a fake server then a fake server is created
    Given sid in server_status
    When chaos was "ENABLED" or disabled for a fake server
    When a route is removed from a fake server
    When a fake server is created
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @sequence
  Scenario: chaos was "ENABLED" or disabled for a fake server then the status of a fake server is retrieved then a fake server is deleted
    Given sid in server_status
    When chaos was "ENABLED" or disabled for a fake server
    When the status of a fake server is retrieved
    When a fake server is deleted
    And every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol
