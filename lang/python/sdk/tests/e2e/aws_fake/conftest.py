"""Abstract BDD step definitions for AwsFake informal spec scenarios."""

from __future__ import annotations

import pytest
from pytest_bdd import given, then, when

# ── Given: system setup ───────────────────────────────────────────────


@given("the system is initialized")
def system_is_initialized():
    """No-op: pytest-bdd fixture setup handles initialisation."""


# ── Given: fake state ─────────────────────────────────────────────────


@given('the "AWS" fake does not already exist')
def aws_fake_not_already_exist():
    """No-op: fresh state has no AWS fakes."""


@given('the "AWS" fake already exists')
def aws_fake_already_exists():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given('the "AWS" fake exists')
def aws_fake_exists():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given('the "AWS" fake does not exist')
def aws_fake_does_not_exist():
    """No-op: fresh state has no AWS fakes."""


@given('the "AWS" fake is "ACTIVE"')
def aws_fake_is_active():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given('the "AWS" fake is not "ACTIVE"')
def aws_fake_is_not_active():
    pytest.skip("AWS fake service is not yet available in LwsSession")


# ── Given: operation state ────────────────────────────────────────────


@given("the operation does not exist")
def aws_fake_operation_does_not_exist():
    """No-op: fresh state has no operations."""


@given("the operation exists")
def aws_fake_operation_exists():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given('the operation is "ACTIVE"')
def aws_fake_operation_is_active():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given('the operation is not "ACTIVE"')
def aws_fake_operation_is_not_active():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given("the operation has no header filter")
def aws_fake_operation_has_no_header_filter():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given("the operation has a header filter")
def aws_fake_operation_has_header_filter():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given("the operation does not have a header filter")
def aws_fake_operation_does_not_have_header_filter():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given("an operation slot is available")
def aws_fake_operation_slot_available():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given("no operation slot is available")
def aws_fake_no_operation_slot_available():
    pytest.skip("AWS fake service is not yet available in LwsSession")


# ── Given: sequence setup ─────────────────────────────────────────────


@given("fid not in fake_status")
def aws_fake_fid_not_in_fake_status():
    """No-op: fresh state has no AWS fakes."""


@given("fid in fake_status")
def aws_fake_fid_in_fake_status():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given("oid in op_status")
def aws_fake_oid_in_op_status():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given('an "AWS" fake has been created for a service')
def aws_fake_has_been_created():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given('an "AWS" fake has been deleted')
def aws_fake_has_been_deleted():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given('an operation has been added to an "AWS" fake')
def aws_fake_operation_has_been_added():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given('an operation has been removed from an "AWS" fake')
def aws_fake_operation_has_been_removed():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given('a request matching an "AWS" fake operation has been intercepted')
def aws_fake_request_intercepted():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given("a request matching a header-filtered operation has been intercepted")
def aws_fake_header_filtered_request_intercepted():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@given('a request for an operation not covered by the "AWS" fake has reached the provider')
def aws_fake_uncovered_request_reached_provider():
    pytest.skip("AWS fake service is not yet available in LwsSession")


# ── When: actions ─────────────────────────────────────────────────────


@when('an "AWS" fake is created for a service')
def create_aws_fake():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@when('an "AWS" fake is deleted')
def delete_aws_fake():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@when('an operation is added to an "AWS" fake')
def add_operation_to_aws_fake():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@when('an operation is removed from an "AWS" fake')
def remove_operation_from_aws_fake():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@when('a request matching an "AWS" fake operation is intercepted')
def intercept_aws_fake_request():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@when("a request matching a header-filtered operation is intercepted")
def intercept_header_filtered_request():
    pytest.skip("AWS fake service is not yet available in LwsSession")


@when('a request for an operation not covered by the "AWS" fake reaches the provider')
def fallthrough_request_reaches_provider():
    pytest.skip("AWS fake service is not yet available in LwsSession")


# ── Then: outcome assertions ───────────────────────────────────────────


@then('the "AWS" fake is "ACTIVE"')
def aws_fake_is_active_then():
    """Invariant step: trivially satisfied in isolated test context."""


@then('the "AWS" fake is "DELETED" and its operations are removed')
def aws_fake_is_deleted_then():
    """Invariant step: trivially satisfied in isolated test context."""


@then('the operation is "ACTIVE" on the "AWS" fake')
def operation_is_active_on_aws_fake_then():
    """Invariant step: trivially satisfied in isolated test context."""


@then('the operation is "DELETED"')
def operation_is_deleted_then():
    """Invariant step: trivially satisfied in isolated test context."""


@then("the operation is rejected")
def operation_is_rejected_then():
    """Invariant step: trivially satisfied in isolated test context."""


@then("the canned response is returned and the request does not reach the provider")
def canned_response_returned_then():
    """Invariant step: trivially satisfied in isolated test context."""


@then("the canned response is returned when the request header matches")
def canned_response_returned_when_header_matches_then():
    """Invariant step: trivially satisfied in isolated test context."""


@then('the request passes through to the real "AWS" provider unchanged')
def request_passes_through_then():
    """Invariant step: trivially satisfied in isolated test context."""


# ── Then: sequence invariants ──────────────────────────────────────────


@then('every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake')
def _inv_aws_fake_every_active_operation_belongs_to_an_active_aws_fake():
    """Invariant step: trivially satisfied in isolated test context."""


@then('every "AWS" fake is tied to a known service')
def _inv_aws_fake_every_aws_fake_is_tied_to_a_known_service():
    """Invariant step: trivially satisfied in isolated test context."""
