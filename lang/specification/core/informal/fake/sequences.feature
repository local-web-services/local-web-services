@fake @generated
Feature: Fake - Action Sequences

  # Generated from FizzBee spec: fake.fizz
  # Safety invariants: ActiveRoutesBelongToActiveServers, ServerProtocolIsValid

  Background:
    Given the system is initialized

  @exhaustive @sequence
  Scenario: a fake server is created then a fake server is deleted
    Given sid not in server_status
    Given a fake server has been created
    When a fake server is deleted
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is created then a route is added to a fake server
    Given sid not in server_status
    Given a fake server has been created
    When a route is added to a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is created then a route is removed from a fake server
    Given sid not in server_status
    Given a fake server has been created
    When a route is removed from a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is created then the status of a fake server is retrieved
    Given sid not in server_status
    Given a fake server has been created
    When the status of a fake server is retrieved
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is created then chaos is enabled or disabled for a fake server
    Given sid not in server_status
    Given a fake server has been created
    When chaos is enabled or disabled for a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is deleted then a fake server is created
    Given sid in server_status
    Given a fake server has been deleted
    When a fake server is created
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is deleted then a route is added to a fake server
    Given sid in server_status
    Given a fake server has been deleted
    When a route is added to a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is deleted then a route is removed from a fake server
    Given sid in server_status
    Given a fake server has been deleted
    When a route is removed from a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is deleted then the status of a fake server is retrieved
    Given sid in server_status
    Given a fake server has been deleted
    When the status of a fake server is retrieved
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is deleted then chaos is enabled or disabled for a fake server
    Given sid in server_status
    Given a fake server has been deleted
    When chaos is enabled or disabled for a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is added to a fake server then a fake server is created
    Given sid in server_status
    Given a route has been added to a fake server
    When a fake server is created
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is added to a fake server then a fake server is deleted
    Given sid in server_status
    Given a route has been added to a fake server
    When a fake server is deleted
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is added to a fake server then a route is removed from a fake server
    Given sid in server_status
    Given a route has been added to a fake server
    When a route is removed from a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is added to a fake server then the status of a fake server is retrieved
    Given sid in server_status
    Given a route has been added to a fake server
    When the status of a fake server is retrieved
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is added to a fake server then chaos is enabled or disabled for a fake server
    Given sid in server_status
    Given a route has been added to a fake server
    When chaos is enabled or disabled for a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is removed from a fake server then a fake server is created
    Given rid in route_status
    Given a route has been removed from a fake server
    When a fake server is created
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is removed from a fake server then a fake server is deleted
    Given rid in route_status
    Given a route has been removed from a fake server
    When a fake server is deleted
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is removed from a fake server then a route is added to a fake server
    Given rid in route_status
    Given a route has been removed from a fake server
    When a route is added to a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is removed from a fake server then the status of a fake server is retrieved
    Given rid in route_status
    Given a route has been removed from a fake server
    When the status of a fake server is retrieved
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is removed from a fake server then chaos is enabled or disabled for a fake server
    Given rid in route_status
    Given a route has been removed from a fake server
    When chaos is enabled or disabled for a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: the status of a fake server is retrieved then a fake server is created
    Given sid in server_status
    Given the status of a fake server has been retrieved
    When a fake server is created
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: the status of a fake server is retrieved then a fake server is deleted
    Given sid in server_status
    Given the status of a fake server has been retrieved
    When a fake server is deleted
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: the status of a fake server is retrieved then a route is added to a fake server
    Given sid in server_status
    Given the status of a fake server has been retrieved
    When a route is added to a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: the status of a fake server is retrieved then a route is removed from a fake server
    Given sid in server_status
    Given the status of a fake server has been retrieved
    When a route is removed from a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: the status of a fake server is retrieved then chaos is enabled or disabled for a fake server
    Given sid in server_status
    Given the status of a fake server has been retrieved
    When chaos is enabled or disabled for a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: chaos is enabled or disabled for a fake server then a fake server is created
    Given sid in server_status
    Given chaos has been enabled or disabled for a fake server
    When a fake server is created
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: chaos is enabled or disabled for a fake server then a fake server is deleted
    Given sid in server_status
    Given chaos has been enabled or disabled for a fake server
    When a fake server is deleted
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: chaos is enabled or disabled for a fake server then a route is added to a fake server
    Given sid in server_status
    Given chaos has been enabled or disabled for a fake server
    When a route is added to a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: chaos is enabled or disabled for a fake server then a route is removed from a fake server
    Given sid in server_status
    Given chaos has been enabled or disabled for a fake server
    When a route is removed from a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: chaos is enabled or disabled for a fake server then the status of a fake server is retrieved
    Given sid in server_status
    Given chaos has been enabled or disabled for a fake server
    When the status of a fake server is retrieved
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is created then a fake server is deleted then a route is added to a fake server
    Given sid not in server_status
    Given a fake server has been created
    Given a fake server has been deleted
    When a route is added to a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is created then a route is added to a fake server then a route is removed from a fake server
    Given sid not in server_status
    Given a fake server has been created
    Given a route has been added to a fake server
    When a route is removed from a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is created then a route is removed from a fake server then the status of a fake server is retrieved
    Given sid not in server_status
    Given a fake server has been created
    Given a route has been removed from a fake server
    When the status of a fake server is retrieved
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is created then the status of a fake server is retrieved then chaos is enabled or disabled for a fake server
    Given sid not in server_status
    Given a fake server has been created
    Given the status of a fake server has been retrieved
    When chaos is enabled or disabled for a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is created then chaos is enabled or disabled for a fake server then a fake server is deleted
    Given sid not in server_status
    Given a fake server has been created
    Given chaos has been enabled or disabled for a fake server
    When a fake server is deleted
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is deleted then a fake server is created then a route is removed from a fake server
    Given sid in server_status
    Given a fake server has been deleted
    Given a fake server has been created
    When a route is removed from a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is deleted then a route is added to a fake server then the status of a fake server is retrieved
    Given sid in server_status
    Given a fake server has been deleted
    Given a route has been added to a fake server
    When the status of a fake server is retrieved
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is deleted then a route is removed from a fake server then chaos is enabled or disabled for a fake server
    Given sid in server_status
    Given a fake server has been deleted
    Given a route has been removed from a fake server
    When chaos is enabled or disabled for a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is deleted then the status of a fake server is retrieved then a fake server is created
    Given sid in server_status
    Given a fake server has been deleted
    Given the status of a fake server has been retrieved
    When a fake server is created
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a fake server is deleted then chaos is enabled or disabled for a fake server then a route is added to a fake server
    Given sid in server_status
    Given a fake server has been deleted
    Given chaos has been enabled or disabled for a fake server
    When a route is added to a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is added to a fake server then a fake server is created then the status of a fake server is retrieved
    Given sid in server_status
    Given a route has been added to a fake server
    Given a fake server has been created
    When the status of a fake server is retrieved
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is added to a fake server then a fake server is deleted then chaos is enabled or disabled for a fake server
    Given sid in server_status
    Given a route has been added to a fake server
    Given a fake server has been deleted
    When chaos is enabled or disabled for a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is added to a fake server then a route is removed from a fake server then a fake server is created
    Given sid in server_status
    Given a route has been added to a fake server
    Given a route has been removed from a fake server
    When a fake server is created
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is added to a fake server then the status of a fake server is retrieved then a fake server is deleted
    Given sid in server_status
    Given a route has been added to a fake server
    Given the status of a fake server has been retrieved
    When a fake server is deleted
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is added to a fake server then chaos is enabled or disabled for a fake server then a route is removed from a fake server
    Given sid in server_status
    Given a route has been added to a fake server
    Given chaos has been enabled or disabled for a fake server
    When a route is removed from a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is removed from a fake server then a fake server is created then chaos is enabled or disabled for a fake server
    Given rid in route_status
    Given a route has been removed from a fake server
    Given a fake server has been created
    When chaos is enabled or disabled for a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is removed from a fake server then a fake server is deleted then a fake server is created
    Given rid in route_status
    Given a route has been removed from a fake server
    Given a fake server has been deleted
    When a fake server is created
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is removed from a fake server then a route is added to a fake server then a fake server is deleted
    Given rid in route_status
    Given a route has been removed from a fake server
    Given a route has been added to a fake server
    When a fake server is deleted
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is removed from a fake server then the status of a fake server is retrieved then a route is added to a fake server
    Given rid in route_status
    Given a route has been removed from a fake server
    Given the status of a fake server has been retrieved
    When a route is added to a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: a route is removed from a fake server then chaos is enabled or disabled for a fake server then the status of a fake server is retrieved
    Given rid in route_status
    Given a route has been removed from a fake server
    Given chaos has been enabled or disabled for a fake server
    When the status of a fake server is retrieved
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: the status of a fake server is retrieved then a fake server is created then a fake server is deleted
    Given sid in server_status
    Given the status of a fake server has been retrieved
    Given a fake server has been created
    When a fake server is deleted
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: the status of a fake server is retrieved then a fake server is deleted then a route is added to a fake server
    Given sid in server_status
    Given the status of a fake server has been retrieved
    Given a fake server has been deleted
    When a route is added to a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: the status of a fake server is retrieved then a route is added to a fake server then a route is removed from a fake server
    Given sid in server_status
    Given the status of a fake server has been retrieved
    Given a route has been added to a fake server
    When a route is removed from a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: the status of a fake server is retrieved then a route is removed from a fake server then chaos is enabled or disabled for a fake server
    Given sid in server_status
    Given the status of a fake server has been retrieved
    Given a route has been removed from a fake server
    When chaos is enabled or disabled for a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: the status of a fake server is retrieved then chaos is enabled or disabled for a fake server then a fake server is created
    Given sid in server_status
    Given the status of a fake server has been retrieved
    Given chaos has been enabled or disabled for a fake server
    When a fake server is created
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: chaos is enabled or disabled for a fake server then a fake server is created then a route is added to a fake server
    Given sid in server_status
    Given chaos has been enabled or disabled for a fake server
    Given a fake server has been created
    When a route is added to a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: chaos is enabled or disabled for a fake server then a fake server is deleted then a route is removed from a fake server
    Given sid in server_status
    Given chaos has been enabled or disabled for a fake server
    Given a fake server has been deleted
    When a route is removed from a fake server
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: chaos is enabled or disabled for a fake server then a route is added to a fake server then the status of a fake server is retrieved
    Given sid in server_status
    Given chaos has been enabled or disabled for a fake server
    Given a route has been added to a fake server
    When the status of a fake server is retrieved
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: chaos is enabled or disabled for a fake server then a route is removed from a fake server then a fake server is created
    Given sid in server_status
    Given chaos has been enabled or disabled for a fake server
    Given a route has been removed from a fake server
    When a fake server is created
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol

  @exhaustive @sequence
  Scenario: chaos is enabled or disabled for a fake server then the status of a fake server is retrieved then a fake server is deleted
    Given sid in server_status
    Given chaos has been enabled or disabled for a fake server
    Given the status of a fake server has been retrieved
    When a fake server is deleted
    Then every "ACTIVE" route belongs to an "ACTIVE" server
    And every server has a valid protocol
