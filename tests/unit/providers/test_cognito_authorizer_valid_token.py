"""Tests for Cognito JWT authorizer."""

from __future__ import annotations

import pytest

from lws.providers.cognito.authorizer import CognitoAuthorizer
from lws.providers.cognito.tokens import TokenIssuer

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


class TestValidToken:
    """Successful token validation."""

    def test_valid_id_token(self, issuer: TokenIssuer, authorizer: CognitoAuthorizer) -> None:
        token = issuer.issue_id_token("sub-123", "alice", {"email": "alice@example.com"})
        claims = authorizer.validate_token(_make_bearer(token))
        assert claims["sub"] == "sub-123"
        assert claims["cognito:username"] == "alice"

    def test_claims_context(self, issuer: TokenIssuer, authorizer: CognitoAuthorizer) -> None:
        token = issuer.issue_id_token("sub-123", "alice", {"email": "alice@example.com"})
        claims = authorizer.validate_token(_make_bearer(token))
        context = authorizer.build_claims_context(claims)
        assert context["sub"] == "sub-123"
        assert context["cognito:username"] == "alice"
        assert context["email"] == "alice@example.com"
        assert "exp" in context
        assert "iat" in context
        # Numeric claims converted to strings
        assert isinstance(context["exp"], str)
        assert isinstance(context["iat"], str)
