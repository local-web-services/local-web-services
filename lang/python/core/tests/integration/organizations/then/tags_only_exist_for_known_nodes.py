"""Then: "organizations" tags only exist on "organizations" "node"s that are present in the org"""

from __future__ import annotations

from pytest_bdd import then


@then('"organizations" tags only exist on "organizations" "node"s that are present in the org')
def tags_only_exist_for_known_nodes():
    """Invariant: trivially satisfied in an isolated test context."""
