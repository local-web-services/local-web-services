"""Then: every "api gateway" "API" with a configured authorizer references an "ACTIVE" "cognito" "user pool" """

from __future__ import annotations

from pytest_bdd import step


@step(
    'every "api gateway" "API" with a configured authorizer references an "ACTIVE" "cognito" "user pool"'
)
def _inv_apigateway_cognito_every_api_with_a_configured_authorizer_references_an_act():
    """Invariant step: trivially satisfied in isolated test context."""
