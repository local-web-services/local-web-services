"""Given: the operation is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the operation is "ACTIVE"')
def aws_fake_operation_is_active():
    """No-op: aws_fake_operation_exists already added the operation in ACTIVE state."""
