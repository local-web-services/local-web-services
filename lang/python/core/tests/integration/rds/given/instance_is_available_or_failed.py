"""Given: the "rds" "instance" will be "AVAILABLE" or "FAILED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "rds" "instance" was "AVAILABLE" or "FAILED"')
@given('the "rds" "instance" will be "AVAILABLE" or "FAILED"')
def instance_is_available_or_failed():
    """No-op: instances are AVAILABLE immediately after creation in lws."""
