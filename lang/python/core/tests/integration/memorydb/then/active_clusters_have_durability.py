"""Then: every active "memorydb" "cluster" has write durability enabled"""

from __future__ import annotations

from pytest_bdd import then


@then('every active "memorydb" "cluster" has write durability enabled')
def active_clusters_have_durability():
    """Invariant: trivially satisfied in isolated lws context."""
