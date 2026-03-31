"""Given: the "elasticsearch" "domain" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "opensearch" "domain" was "ACTIVE"')
@given('the "elasticsearch" "domain" was "ACTIVE"')
def domain_is_active():
    """No-op: domains are ACTIVE immediately after creation in lws."""
