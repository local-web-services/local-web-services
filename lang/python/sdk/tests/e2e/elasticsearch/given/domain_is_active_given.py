"""Given: the "elasticsearch" "domain" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticsearch" "domain" was "ACTIVE"')
def domain_is_active_given():
    """No-op: lws returns domains as ACTIVE immediately after creation."""
