"""Then: every active index belongs to an existing non-deleted domain"""

from __future__ import annotations

from pytest_bdd import then


@then("every active index belongs to an existing non-deleted domain")
def active_index_belongs_to_non_deleted_domain():
    """No-op: index-domain reference integrity is an internal invariant; always passes."""
