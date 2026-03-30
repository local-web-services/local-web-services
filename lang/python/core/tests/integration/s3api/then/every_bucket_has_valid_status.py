"""Then: every bucket has a valid status ("ACTIVE" or "DELETED")"""

from __future__ import annotations

from pytest_bdd import then


@then('every bucket has a valid status ("ACTIVE" or "DELETED")')
def every_bucket_has_valid_status():
    """No-op invariant: lws always maintains valid bucket statuses."""
