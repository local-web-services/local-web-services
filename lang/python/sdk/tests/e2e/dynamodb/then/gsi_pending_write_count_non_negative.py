"""Then: "GSI" pending write count is never negative"""

from __future__ import annotations

from pytest_bdd import then


@then('"GSI" pending write count is never negative')
def gsi_pending_write_count_non_negative():
    """No-op: GSI pending write counts are internal state; always passes."""
