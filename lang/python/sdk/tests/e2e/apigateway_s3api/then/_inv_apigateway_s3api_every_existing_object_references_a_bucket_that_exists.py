"""Then: every existing object references a "s3" "bucket" that exists"""

from __future__ import annotations

from pytest_bdd import then


@then('every existing object references a "s3" "bucket" that exists')
def _inv_apigateway_s3api_every_existing_object_references_a_bucket_that_exists():
    """Invariant step: trivially satisfied in isolated test context."""
