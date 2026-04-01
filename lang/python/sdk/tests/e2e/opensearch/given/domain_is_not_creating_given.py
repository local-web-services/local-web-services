"""Given: the "opensearch" "domain" was not "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "domain" was not "CREATING"')
def domain_is_not_creating_given():
    """No-op: domains are not in CREATING state by default."""
