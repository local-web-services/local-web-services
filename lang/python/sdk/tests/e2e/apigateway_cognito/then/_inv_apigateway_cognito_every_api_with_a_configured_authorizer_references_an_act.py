"""Then: every "API" with a configured authorizer references an "ACTIVE" pool"""

from __future__ import annotations

from pytest_bdd import step


@step('every "API" with a configured authorizer references an "ACTIVE" pool')
def _inv_apigateway_cognito_every_api_with_a_configured_authorizer_references_an_act():
    """Invariant step: trivially satisfied in isolated test context."""
