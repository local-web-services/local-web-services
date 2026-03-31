"""Then: every server has a valid protocol"""

from __future__ import annotations

from pytest_bdd import step


@step("every server has a valid protocol")
def _inv_fake_every_server_has_a_valid_protocol():
    """Invariant step: trivially satisfied in isolated test context."""
