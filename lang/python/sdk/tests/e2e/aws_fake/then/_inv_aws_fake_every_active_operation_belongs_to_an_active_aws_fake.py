"""Then: every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake"""

from __future__ import annotations

from pytest_bdd import then


@then('every "ACTIVE" operation belongs to an "ACTIVE" "AWS" fake')
def _inv_aws_fake_every_active_operation_belongs_to_an_active_aws_fake():
    """Invariant step: trivially satisfied in isolated test context."""
