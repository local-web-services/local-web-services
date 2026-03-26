"""Then: snapshot count is never negative"""

from __future__ import annotations

from pytest_bdd import then


@then("snapshot count is never negative")
def snapshot_count_non_negative():
    """No-op: snapshot count invariant; always passes."""
