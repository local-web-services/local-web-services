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


# ---------------------------------------------------------------------------
# Error Cases
# ---------------------------------------------------------------------------


class TestMissingHeader:
    """Missing or malformed Authorization header."""

    def test_missing_header(self, authorizer: CognitoAuthorizer) -> None:
        with pytest.raises(AuthorizationError, match="Missing"):
            authorizer.validate_token(None)

    def test_empty_header(self, authorizer: CognitoAuthorizer) -> None:
        with pytest.raises(AuthorizationError, match="Missing"):
            authorizer.validate_token("")

    def test_no_bearer_prefix(self, authorizer: CognitoAuthorizer) -> None:
        with pytest.raises(AuthorizationError, match="Invalid Authorization"):
            authorizer.validate_token("Token xyz")

    def test_bare_token(self, authorizer: CognitoAuthorizer) -> None:
        with pytest.raises(AuthorizationError, match="Invalid Authorization"):
            authorizer.validate_token("just-a-token")


class TestInvalidToken:
    """Invalid or expired tokens."""

    def test_tampered_token(self, issuer: TokenIssuer, authorizer: CognitoAuthorizer) -> None:
        token = issuer.issue_id_token("sub-123", "alice", {})
        tampered = token[:-5] + "XXXXX"
        with pytest.raises(AuthorizationError, match="Invalid token"):
            authorizer.validate_token(_make_bearer(tampered))

    def test_wrong_issuer(self, authorizer: CognitoAuthorizer) -> None:
        other_issuer = TokenIssuer(
            user_pool_id="us-east-1_WrongPool",
            client_id="test-client-id",
        )
        token = other_issuer.issue_id_token("sub-123", "alice", {})
        with pytest.raises(AuthorizationError):
            authorizer.validate_token(_make_bearer(token))

    def test_garbage_token(self, authorizer: CognitoAuthorizer) -> None:
        with pytest.raises(AuthorizationError, match="Invalid token"):
            authorizer.validate_token("Bearer not.a.valid.jwt")


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
