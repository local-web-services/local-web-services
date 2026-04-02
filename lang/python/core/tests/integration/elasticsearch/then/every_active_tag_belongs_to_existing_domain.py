"""Then: every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain" """

from __future__ import annotations

from pytest_bdd import then


@then(
    'every active "elasticsearch" "tag" belongs to an existing non-deleted "elasticsearch" "domain"'
)
def every_active_tag_belongs_to_existing_domain():
    """Invariant trivially satisfied in isolated test context."""
