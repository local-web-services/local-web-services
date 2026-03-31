"""Given: the "rds" "instance" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "rds" "instance" was "AVAILABLE"')
def instance_is_available_given():
    """No-op: lws returns instances as AVAILABLE immediately after creation."""
