"""Given: the "aws fake" "operation" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "aws fake" "operation" was "ACTIVE"')
def aws_fake_operation_is_active():
    """No-op: aws_fake_operation_exists already added the operation in ACTIVE state."""
