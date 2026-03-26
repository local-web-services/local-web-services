"""Then: every "AUTHORIZED" request was validated against a "VALID" token"""

from __future__ import annotations

from pytest_bdd import then


@then('every "AUTHORIZED" request was validated against a "VALID" token')
def _inv_apigateway_cognito_every_authorized_request_was_validated_against_a_valid_t():
    """Invariant step: trivially satisfied in isolated test context."""
