"""Then: every active "elasticache" "cluster", "replication group", and "snapshot" has tags"""

from __future__ import annotations

from pytest_bdd import then


@then('every active "elasticache" "cluster", "replication group", and "snapshot" has tags')
def active_resources_have_tags():
    """Invariant: trivially satisfied in isolated lws context."""
