"""Tests for Cognito JWT authorizer."""

from __future__ import annotations

import time

import jwt
import pytest

from ldk.providers.cognito.authorizer import AuthorizationError, CognitoAuthorizer
from ldk.providers.cognito.tokens import TokenIssuer

# ---------------------------------------------------------------------------
# Fixtures
# ---------------------------------------------------------------------------


@pytest.fixture
def issuer() -> TokenIssuer:
    """Create a TokenIssuer for testing."""
    return TokenIssuer(
        user_pool_id="us-east-1_TestPool",
        client_id="test-client-id",
        region="us-east-1",
    )


@pytest.fixture
def authorizer(issuer: TokenIssuer) -> CognitoAuthorizer:
    """Create a CognitoAuthorizer for testing."""
    return CognitoAuthorizer(token_issuer=issuer)


def _make_bearer(token: str) -> str:
    return f"Bearer {token}"


# ---------------------------------------------------------------------------
# Successful Validation Tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Error Cases
# ---------------------------------------------------------------------------


class TestExpiredToken:
    """Expired token handling."""

    def test_expired_token(self, issuer: TokenIssuer, authorizer: CognitoAuthorizer) -> None:
        # Manually create a token that's already expired
        claims = {
            "sub": "sub-123",
            "cognito:username": "alice",
            "iss": issuer.issuer,
            "aud": issuer.client_id,
            "exp": int(time.time()) - 3600,
            "iat": int(time.time()) - 7200,
            "token_use": "id",
        }
        token = jwt.encode(
            claims,
            issuer.get_private_key_pem(),
            algorithm="RS256",
        )
        with pytest.raises(AuthorizationError, match="expired"):
            authorizer.validate_token(_make_bearer(token))
