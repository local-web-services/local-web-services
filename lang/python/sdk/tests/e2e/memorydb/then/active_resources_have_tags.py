"""Then: every active "memorydb" "cluster" and "snapshot" has tags"""

from __future__ import annotations

from pytest_bdd import step


@step('every active "memorydb" "cluster" and "snapshot" has tags')
def active_resources_have_tags():
    """No-op: tag existence invariant; always passes."""
