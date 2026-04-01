"""Given: the server was "ACTIVE" """

from __future__ import annotations

from pytest_bdd import given


@given('the server was "ACTIVE"')
def server_is_active():
    """No-op: server_exists already created the server in ACTIVE state."""
