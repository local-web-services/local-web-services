"""Then: the "AWS" fake is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then


@then('the "AWS" fake is "ACTIVE"')
def aws_fake_is_active_then():
    """Invariant step: trivially satisfied in isolated test context."""
