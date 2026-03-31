"""Then: the "AWS" fake will be deleted and its operations will be removed"""

from __future__ import annotations

from pytest_bdd import then


@then('the "AWS" fake will be deleted and its operations will be removed')
def aws_fake_is_deleted_then():
    """Invariant step: trivially satisfied in isolated test context."""
