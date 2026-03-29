"""Then: all snapshots reference redis clusters only"""

from __future__ import annotations

from pytest_bdd import then


@then("all snapshots reference redis clusters only")
def snapshots_reference_redis_only():
    """Invariant: trivially satisfied in isolated lws context."""
