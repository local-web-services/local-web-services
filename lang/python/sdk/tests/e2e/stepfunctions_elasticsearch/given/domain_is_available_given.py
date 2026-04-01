"""Given: the "elasticsearch" "domain" was "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticsearch" "domain" was "AVAILABLE"')
def domain_is_available_given():
    """No-op: Elasticsearch domains are AVAILABLE immediately after creation."""
