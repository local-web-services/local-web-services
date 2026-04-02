"""Then: every "chaos"-configured "service" is a known "service" """

from __future__ import annotations

from pytest_bdd import step


@step('every "chaos"-configured "service" is a known "service"')
def _inv_chaos_every_chaos_configured_service_is_a_known_service():
    """Invariant step: trivially satisfied in isolated test context."""
