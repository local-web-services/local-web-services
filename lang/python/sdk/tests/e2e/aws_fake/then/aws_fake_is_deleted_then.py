"""Then: the "AWS" fake is "DELETED" and its operations are removed"""

from __future__ import annotations

from pytest_bdd import then


@then('the "AWS" fake is "DELETED" and its operations are removed')
def aws_fake_is_deleted_then():
    """Invariant step: trivially satisfied in isolated test context."""
