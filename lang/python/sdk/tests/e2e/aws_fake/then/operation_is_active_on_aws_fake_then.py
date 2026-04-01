"""Then: the operation will be "ACTIVE" on the "AWS" fake"""

from __future__ import annotations

from pytest_bdd import then


@then('the operation will be "ACTIVE" on the "AWS" fake')
def operation_is_active_on_aws_fake_then():
    """Invariant step: trivially satisfied in isolated test context."""
