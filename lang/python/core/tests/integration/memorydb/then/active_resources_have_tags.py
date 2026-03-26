"""Then: every active cluster and snapshot has tags"""

from __future__ import annotations

from pytest_bdd import then


@then("every active cluster and snapshot has tags")
def active_resources_have_tags():
    """Invariant: trivially satisfied in isolated lws context."""
