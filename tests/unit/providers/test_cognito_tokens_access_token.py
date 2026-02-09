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


class TestAccessToken:
    """Access token generation and validation."""

    def test_access_token_round_trip(self, issuer: TokenIssuer) -> None:
        token = issuer.issue_access_token("sub-123", "alice")
        claims = issuer.decode_token(token, token_use="access")
        assert claims["sub"] == "sub-123"
        assert claims["cognito:username"] == "alice"
        assert claims["token_use"] == "access"

    def test_access_token_has_scope(self, issuer: TokenIssuer) -> None:
        token = issuer.issue_access_token("sub-123", "alice")
        claims = issuer.decode_token(token, token_use="access")
        assert "scope" in claims

    def test_access_token_has_client_id(self, issuer: TokenIssuer) -> None:
        token = issuer.issue_access_token("sub-123", "alice")
        claims = issuer.decode_token(token, token_use="access")
        assert claims["client_id"] == "test-client-id"
