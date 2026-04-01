"""Given: a service call is delayed by chaos latency injection"""

from __future__ import annotations

from pytest_bdd import given


@given("a service call is delayed by chaos latency injection")
def chaos_service_call_delayed():
    """No-op: prior latency injection is represented by state already set up."""
