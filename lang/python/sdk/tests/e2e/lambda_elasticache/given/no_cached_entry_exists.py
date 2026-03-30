"""Given: no "CACHED" entry exists"""

from __future__ import annotations

from pytest_bdd import given


@given('no "CACHED" entry exists')
def no_cached_entry_exists():
    """No-op: fresh state has no cached entries."""
