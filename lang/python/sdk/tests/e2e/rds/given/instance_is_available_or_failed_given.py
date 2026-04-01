"""Given: the "rds" "instance" was "AVAILABLE" or "FAILED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "rds" "instance" was "AVAILABLE" or "FAILED"')
def instance_is_available_or_failed_given():
    """No-op: lws returns instances as AVAILABLE immediately after creation."""
