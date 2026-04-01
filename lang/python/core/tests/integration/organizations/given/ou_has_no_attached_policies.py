"""Given: the "organizations" "organizational unit" has no attached policies"""

from __future__ import annotations

from pytest_bdd import given


@given('the "organizations" "organizational unit" has no attached policies')
def ou_has_no_attached_policies():
    """No-op: freshly created OU has no policies attached."""
