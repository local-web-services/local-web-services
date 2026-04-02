"""Given: the "operation" did not exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "operation" did not exist')
def aws_fake_operation_does_not_exist():
    """No-op: fresh state has no operations."""
