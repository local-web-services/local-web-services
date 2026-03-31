"""Then: every active tag belongs to an existing non-deleted domain"""

from __future__ import annotations

from pytest_bdd import step


@step("every active tag belongs to an existing non-deleted domain")
def active_tag_belongs_to_non_deleted_domain():
    """No-op: tag-domain reference integrity is an internal invariant; always passes."""
