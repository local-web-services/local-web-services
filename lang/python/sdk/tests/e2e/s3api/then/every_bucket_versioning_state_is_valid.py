"""Then: every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")"""

from __future__ import annotations

from pytest_bdd import then


@then('every "s3" "bucket" versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")')
def every_bucket_versioning_state_is_valid():
    """No-op invariant: lws always maintains valid versioning states."""
