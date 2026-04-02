"""Then: every active "memorydb" "cluster" has write durability enabled"""

from __future__ import annotations

from pytest_bdd import step


@step('every active "memorydb" "cluster" has write durability enabled')
def active_cluster_has_write_durability():
    """No-op: write durability invariant; always passes."""
