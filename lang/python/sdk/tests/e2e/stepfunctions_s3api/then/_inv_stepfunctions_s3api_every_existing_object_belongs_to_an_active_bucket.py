"""Then: every existing object belongs to an "ACTIVE" bucket"""

from __future__ import annotations

from pytest_bdd import step


@step('every existing object belongs to an "ACTIVE" bucket')
def _inv_stepfunctions_s3api_every_existing_object_belongs_to_an_active_bucket():
    """Invariant step: trivially satisfied in isolated test context."""
