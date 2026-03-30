"""Given: the domain is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the domain is "ACTIVE"')
def domain_is_active():
    """No-op: domains are ACTIVE immediately after creation in lws."""
