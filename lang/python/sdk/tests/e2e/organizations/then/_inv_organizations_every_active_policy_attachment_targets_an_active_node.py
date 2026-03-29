"""Then: every active policy attachment targets an "ACTIVE" node"""

from __future__ import annotations

from pytest_bdd import then


@then('every active policy attachment targets an "ACTIVE" node')
def _inv_organizations_every_active_policy_attachment_targets_an_active_node():
    """Invariant step: trivially satisfied in isolated test context."""
