"""Given: no operation slot is available"""

from __future__ import annotations

from pytest_bdd import given


@given("no operation slot is available")
def aws_fake_no_operation_slot_available():
    """No-op: AWS fake services have no maximum operation limit."""
