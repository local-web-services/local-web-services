"""Given: the "fake" "server" did not already exist"""

from __future__ import annotations

from pytest_bdd import given


@given('the "fake" "server" did not already exist')
def server_does_not_already_exist():
    """No-op: fresh state has no fake servers."""
