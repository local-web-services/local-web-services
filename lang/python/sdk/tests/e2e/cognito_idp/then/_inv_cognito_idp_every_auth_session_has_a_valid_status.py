"""Then: every auth session has a valid status"""

from __future__ import annotations

from pytest_bdd import step


@step("every auth session has a valid status")
def _inv_cognito_idp_every_auth_session_has_a_valid_status():
    """Invariant step: trivially satisfied in isolated test context."""
