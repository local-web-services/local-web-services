"""Given: the "organizations" "organizational unit" has no child organizational units"""

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "organizational unit" has no child organizational units')
def ou_has_no_child_ous():
    """No-op: freshly created OU has no children."""
