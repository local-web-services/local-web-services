"""Given: the server is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the server is "ACTIVE"')
def server_is_active():
    """No-op: server_exists already created the server in ACTIVE state."""
