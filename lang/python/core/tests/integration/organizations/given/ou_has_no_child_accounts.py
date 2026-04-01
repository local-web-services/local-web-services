"""Given: the "organizations" "organizational unit" has no child accounts"""

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "organizational unit" has no child accounts')
def ou_has_no_child_accounts():
    """No-op: freshly created OU has no accounts."""
