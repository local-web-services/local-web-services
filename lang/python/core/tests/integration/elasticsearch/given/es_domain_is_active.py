"""Given: the "elasticsearch" "domain" was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the "elasticsearch" "domain" was "ACTIVE"')
def es_domain_is_active():
    """No-op: domains are ACTIVE immediately after creation in lws."""
