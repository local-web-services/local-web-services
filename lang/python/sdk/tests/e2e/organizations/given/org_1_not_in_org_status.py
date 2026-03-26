"""Given: 'org-1' not in org_status"""

from __future__ import annotations

from pytest_bdd import given


@given("'org-1' not in org_status")
def org_1_not_in_org_status():
    """No-op: fresh state has no organizations."""
