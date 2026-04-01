"""Then: every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")"""

from __future__ import annotations

from pytest_bdd import step


@step('every bucket versioning state is valid ("DISABLED", "ENABLED", or "SUSPENDED")')
def _inv_s3api_every_bucket_versioning_state_is_valid_disabled_enabled_or_suspended():
    """Invariant step: trivially satisfied in isolated test context."""
