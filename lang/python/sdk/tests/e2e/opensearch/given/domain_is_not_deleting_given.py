"""Given: the "opensearch" "domain" was not "DELETING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "domain" was not "DELETING"')
def domain_is_not_deleting_given():
    """No-op: domains are not in DELETING state by default."""
