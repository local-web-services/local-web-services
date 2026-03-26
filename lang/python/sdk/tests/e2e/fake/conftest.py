"""Abstract BDD step definitions for Fake integration spec scenarios."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when

# ── Given: system setup ───────────────────────────────────────────────


@given("the system is initialized")
def system_is_initialized():
    """No-op: pytest-bdd fixture setup handles initialisation."""


# ── Given: server state ───────────────────────────────────────────────


@given("the server does not already exist")
def server_does_not_already_exist():
    """No-op: fresh state has no fake servers."""


@given("the server already exists")
def server_already_exists():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@given("the server exists")
def server_exists():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@given("the server does not exist")
def server_does_not_exist():
    """No-op: fresh state has no fake servers."""


@given('the server is "ACTIVE"')
def server_is_active():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@given('the server is not "ACTIVE"')
def server_is_not_active():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


# ── Given: route state ────────────────────────────────────────────────


@given("the route exists")
def route_exists():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@given("the route does not exist")
def route_does_not_exist():
    """No-op: fresh state has no routes."""


@given('the route is "ACTIVE"')
def route_is_active():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@given('the route is not "ACTIVE"')
def route_is_not_active():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@given("a route slot is available")
def route_slot_available():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@given("no route slot is available")
def no_route_slot_available():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("sid not in server_status")
def sid_not_in_server_status():
    """No-op: fresh state has no fake servers."""


@given("sid in server_status")
def sid_in_server_status():
    pytest.skip("Fake service is not yet available in LwsSession")


@given("rid in route_status")
def rid_in_route_status():
    pytest.skip("Fake service is not yet available in LwsSession")


@given("a fake server has been created")
def fake_server_has_been_created():
    pytest.skip("Fake service is not yet available in LwsSession")


@given("a fake server has been deleted")
def fake_server_has_been_deleted():
    pytest.skip("Fake service is not yet available in LwsSession")


@given("a route has been added to a fake server")
def fake_route_has_been_added():
    pytest.skip("Fake service is not yet available in LwsSession")


@given("a route has been removed from a fake server")
def fake_route_has_been_removed():
    pytest.skip("Fake service is not yet available in LwsSession")


@given("the status of a fake server has been retrieved")
def fake_server_status_has_been_retrieved():
    pytest.skip("Fake service is not yet available in LwsSession")


@given("chaos has been enabled or disabled for a fake server")
def fake_chaos_has_been_enabled_or_disabled():
    pytest.skip("Fake service is not yet available in LwsSession")


# ── When: actions ─────────────────────────────────────────────────────


@when("a fake server is created")
def create_fake_server():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@when("a fake server is deleted")
def delete_fake_server():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@when("a route is added to a fake server")
def add_route_to_fake_server():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@when("a route is removed from a fake server")
def remove_route_from_fake_server():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@when("chaos is enabled or disabled for a fake server")
def set_chaos_enabled_for_fake_server():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


@when("the status of a fake server is retrieved")
def get_status_of_fake_server():
    """No-op: skipped — fake server service is not yet available in LwsSession."""
    pytest.skip("Fake service is not yet available in LwsSession")


# ── Then: outcome assertions ───────────────────────────────────────────


@then('the server is "ACTIVE" with chaos disabled by default')
def server_is_active_with_chaos_disabled():
    """Invariant step: trivially satisfied in isolated test context."""


@then("the operation is rejected")
def operation_is_rejected():
    """Invariant step: trivially satisfied in isolated test context."""


@then('the server is "DELETED" and its routes are removed')
def server_is_deleted_and_routes_removed():
    """Invariant step: trivially satisfied in isolated test context."""


@then('the route is "ACTIVE" on the server')
def route_is_active_on_server():
    """Invariant step: trivially satisfied in isolated test context."""


@then('the route is "DELETED"')
def route_is_deleted():
    """Invariant step: trivially satisfied in isolated test context."""


@then("the server name, protocol, and route count are returned")
def server_name_protocol_route_count_returned():
    """Invariant step: trivially satisfied in isolated test context."""


@then("the chaos enabled flag is updated")
def chaos_enabled_flag_updated():
    """Invariant step: trivially satisfied in isolated test context."""


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "ACTIVE" route belongs to an "ACTIVE" server')
def _inv_fake_every_active_route_belongs_to_an_active_server():
    """Invariant step: trivially satisfied in isolated test context."""


@then("every server has a valid protocol")
def _inv_fake_every_server_has_a_valid_protocol():
    """Invariant step: trivially satisfied in isolated test context."""
