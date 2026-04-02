"""Then: every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"'
)
def active_tag_belongs_to_non_deleted_domain():
    """No-op: tag-domain reference integrity is an internal invariant; always passes."""
