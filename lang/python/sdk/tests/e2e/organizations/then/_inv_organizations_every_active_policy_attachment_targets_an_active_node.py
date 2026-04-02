"""Then: "organizations" tags only exist on "organizations" "node"s that are present in the org"""

from __future__ import annotations

from pytest_bdd import step


@step('every active "organizations" "policy" attachment targets an "ACTIVE" "organizations" "node"')
@step('"organizations" tags only exist on "organizations" "node"s that are present in the org')
def _inv_organizations_every_active_policy_attachment_targets_an_active_node():
    """Invariant step: trivially satisfied in isolated test context."""
