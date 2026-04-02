"""Given: no "CACHED" "elasticache" "entry" existed"""

from __future__ import annotations

from pytest_bdd import given


@given('no "CACHED" "elasticache" "entry" existed')
def no_cached_entry_exists():
    """No-op: fresh state has no cached entries."""
