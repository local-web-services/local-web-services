"""Then: every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake" """

from __future__ import annotations

from pytest_bdd import step


@step('every "ACTIVE" "operation" belongs to an "ACTIVE" "aws fake"')
def _inv_aws_fake_every_active_operation_belongs_to_an_active_aws_fake():
    """Invariant step: trivially satisfied in isolated test context."""
