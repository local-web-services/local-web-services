"""Given: a service call has been injected with a chaos error"""

from __future__ import annotations

from pytest_bdd import given


@given("a service call has been injected with a chaos error")
def chaos_service_call_injected_with_error():
    """No-op: prior chaos error injection is represented by state already set up."""
