"""Given: the local domain is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the local domain is "ACTIVE"')
def local_domain_is_active_given():
    """No-op: lws returns domains as ACTIVE immediately after creation."""
