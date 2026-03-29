"""Given: the namespace is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the namespace is "ACTIVE"')
def namespace_is_active_given():
    """No-op: lws returns namespaces as ACTIVE immediately after creation."""
