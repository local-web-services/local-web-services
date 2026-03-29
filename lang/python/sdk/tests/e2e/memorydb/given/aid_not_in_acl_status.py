"""Given: aid not in acl_status"""

from __future__ import annotations

from pytest_bdd import given


@given("aid not in acl_status")
def aid_not_in_acl_status():
    """No-op: fresh state has no ACLs."""
