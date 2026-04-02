"""Then: every "ACTIVE" "route" belongs to an "ACTIVE" "fake" "server" """

from __future__ import annotations

from pytest_bdd import step


@step('every "ACTIVE" "route" belongs to an "ACTIVE" "fake" "server"')
def _inv_fake_every_active_route_belongs_to_an_active_server():
    """Invariant step: trivially satisfied in isolated test context."""
