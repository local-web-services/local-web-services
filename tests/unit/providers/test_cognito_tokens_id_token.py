"""Tests for Cognito token issuance and JWKS."""

from __future__ import annotations

import pytest

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


# ---------------------------------------------------------------------------
# JWKS Tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# ID Token Tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Access Token Tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Refresh Token Tests
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# Token Validation Error Tests
# ---------------------------------------------------------------------------


class TestIdToken:
    """ID token generation and validation."""

    def test_id_token_round_trip(self, issuer: TokenIssuer) -> None:
        token = issuer.issue_id_token("sub-123", "alice", {"email": "alice@example.com"})
        claims = issuer.decode_token(token, token_use="id")
        assert claims["sub"] == "sub-123"
        assert claims["cognito:username"] == "alice"
        assert claims["email"] == "alice@example.com"
        assert claims["token_use"] == "id"

    def test_id_token_has_required_claims(self, issuer: TokenIssuer) -> None:
        token = issuer.issue_id_token("sub-123", "alice", {})
        claims = issuer.decode_token(token, token_use="id")
        assert "sub" in claims
        assert "cognito:username" in claims
        assert "iss" in claims
        assert "aud" in claims
        assert "exp" in claims
        assert "iat" in claims
        assert claims["token_use"] == "id"

    def test_id_token_issuer(self, issuer: TokenIssuer) -> None:
        token = issuer.issue_id_token("sub-123", "alice", {})
        claims = issuer.decode_token(token, token_use="id")
        assert claims["iss"] == "https://cognito-idp.us-east-1.amazonaws.com/us-east-1_TestPool"

    def test_id_token_audience(self, issuer: TokenIssuer) -> None:
        token = issuer.issue_id_token("sub-123", "alice", {})
        claims = issuer.decode_token(token, token_use="id")
        assert claims["aud"] == "test-client-id"

    def test_id_token_expiry(self, issuer: TokenIssuer) -> None:
        token = issuer.issue_id_token("sub-123", "alice", {})
        claims = issuer.decode_token(token, token_use="id")
        assert claims["exp"] > claims["iat"]
        assert claims["exp"] - claims["iat"] == 3600
