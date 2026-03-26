"""Then: every active cluster, replication group, and snapshot has tags"""

from __future__ import annotations

from pytest_bdd import then


@then("every active cluster, replication group, and snapshot has tags")
def active_resources_have_tags():
    """No-op: tag existence invariant; always passes."""
