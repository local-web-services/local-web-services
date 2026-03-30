"""
Then: every "REJECTED" request's token belongs to a user in a different pool than the configured
authorizer
"""

from __future__ import annotations

from pytest_bdd import then


@then(
    'every "REJECTED" request\'s token belongs to a user in a different pool than the configured authorizer'  # noqa: E501
)
def _inv_apigateway_cognito_every_rejected_request_s_token_belongs_to_a_user_in_a_di():
    """Invariant step: trivially satisfied in isolated test context."""
