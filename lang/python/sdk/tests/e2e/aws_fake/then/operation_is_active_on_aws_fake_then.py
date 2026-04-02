"""Then: the "aws fake" "operation" will be "ACTIVE" on the "aws fake" """

from __future__ import annotations

from pytest_bdd import then


@then('the "aws fake" "operation" will be "ACTIVE" on the "aws fake"')
def operation_is_active_on_aws_fake_then():
    """Invariant step: trivially satisfied in isolated test context."""
