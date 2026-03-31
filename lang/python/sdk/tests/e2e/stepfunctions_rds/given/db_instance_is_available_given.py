"""Given: the "DB" instance was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "DB" instance was "AVAILABLE"')
def db_instance_is_available_given():
    """No-op: RDS DB clusters are AVAILABLE immediately after creation."""
