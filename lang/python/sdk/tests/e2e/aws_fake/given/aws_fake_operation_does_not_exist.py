"""Given: the operation does not exist"""

from __future__ import annotations

from pytest_bdd import given


@given("the operation does not exist")
def aws_fake_operation_does_not_exist():
    """No-op: fresh state has no operations."""
