"""Given: the domain is "AVAILABLE" """

from __future__ import annotations

from pytest_bdd import given


@given('the domain is "AVAILABLE"')
def domain_is_available_given():
    """No-op: Elasticsearch domains are AVAILABLE immediately after creation."""
