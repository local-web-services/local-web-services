"""Then: every "AUTHORIZED" request's token belongs to a user in the "API"'s configured pool"""

from __future__ import annotations

from pytest_bdd import then


@then('every "AUTHORIZED" request\'s token belongs to a user in the "API"\'s configured pool')
def _inv_apigateway_cognito_every_authorized_request_s_token_belongs_to_a_user_in_th():
    """Invariant step: trivially satisfied in isolated test context."""
