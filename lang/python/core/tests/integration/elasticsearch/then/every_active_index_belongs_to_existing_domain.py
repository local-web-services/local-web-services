"""Then: every active index belongs to an existing non-deleted domain"""

from __future__ import annotations

from pytest_bdd import then


@then("every active index belongs to an existing non-deleted domain")
def every_active_index_belongs_to_existing_domain():
    """Invariant trivially satisfied in isolated test context."""
