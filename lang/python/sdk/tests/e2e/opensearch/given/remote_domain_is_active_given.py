"""Given: the remote domain is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the remote domain is "ACTIVE"')
def remote_domain_is_active_given():
    """No-op: lws returns domains as ACTIVE immediately after creation."""
