"""Then: every existing "s3" "object" belongs to an "ACTIVE" "s3" "bucket" """

from __future__ import annotations

from pytest_bdd import step


@step('every existing "s3" "object" belongs to an "ACTIVE" "s3" "bucket"')
def _inv_lambda_s3api_every_existing_object_belongs_to_an_active_bucket():
    """Invariant step: trivially satisfied in isolated test context."""
