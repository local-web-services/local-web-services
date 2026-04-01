"""Given: the "opensearch" "domain" was not "DELETED" """

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "domain" was not "DELETED"')
def domain_is_not_deleted_given():
    """No-op: domains are not deleted by default."""
