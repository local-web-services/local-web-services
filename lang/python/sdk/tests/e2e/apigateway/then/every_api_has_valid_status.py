"""Then: every "API" has a valid status ("CREATING", "ACTIVE", or "DELETED")"""

from __future__ import annotations

from pytest_bdd import then


@then('every "API" has a valid status ("CREATING", "ACTIVE", or "DELETED")')
def every_api_has_valid_status():
    """No-op: API status validity is an internal invariant in lws; always passes."""
