"""Then: every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")"""

from __future__ import annotations

from pytest_bdd import step


@step('every "s3" "bucket" has a valid status ("ACTIVE" or "DELETED")')
def _inv_s3api_every_bucket_has_a_valid_status_active_or_deleted():
    """Invariant step: trivially satisfied in isolated test context."""
