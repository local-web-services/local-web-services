"""Given: an "operation" "slot" was "available" """

from __future__ import annotations

from pytest_bdd import given


@given('an "operation" "slot" was "available"')
def aws_fake_operation_slot_available():
    """No-op: AWS fake services have no maximum operation limit."""
