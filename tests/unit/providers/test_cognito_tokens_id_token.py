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
        # Arrange
        expected_sub = "sub-123"
        expected_username = "alice"
        expected_email = "alice@example.com"
        expected_token_use = "id"

        # Act
        token = issuer.issue_id_token(expected_sub, expected_username, {"email": expected_email})
        claims = issuer.decode_token(token, token_use=expected_token_use)

        # Assert
        assert claims["sub"] == expected_sub
        assert claims["cognito:username"] == expected_username
        assert claims["email"] == expected_email
        assert claims["token_use"] == expected_token_use

    def test_id_token_has_required_claims(self, issuer: TokenIssuer) -> None:
        # Act
        token = issuer.issue_id_token("sub-123", "alice", {})
        claims = issuer.decode_token(token, token_use="id")

        # Assert
        expected_token_use = "id"
        assert "sub" in claims
        assert "cognito:username" in claims
        assert "iss" in claims
        assert "aud" in claims
        assert "exp" in claims
        assert "iat" in claims
        assert claims["token_use"] == expected_token_use

    def test_id_token_issuer(self, issuer: TokenIssuer) -> None:
        # Act
        token = issuer.issue_id_token("sub-123", "alice", {})
        claims = issuer.decode_token(token, token_use="id")

        # Assert
        expected_issuer = "https://cognito-idp.us-east-1.amazonaws.com/us-east-1_TestPool"
        actual_issuer = claims["iss"]
        assert actual_issuer == expected_issuer

    def test_id_token_audience(self, issuer: TokenIssuer) -> None:
        # Act
        token = issuer.issue_id_token("sub-123", "alice", {})
        claims = issuer.decode_token(token, token_use="id")

        # Assert
        expected_audience = "test-client-id"
        actual_audience = claims["aud"]
        assert actual_audience == expected_audience

    def test_id_token_expiry(self, issuer: TokenIssuer) -> None:
        # Act
        token = issuer.issue_id_token("sub-123", "alice", {})
        claims = issuer.decode_token(token, token_use="id")

        # Assert
        expected_ttl = 3600
        assert claims["exp"] > claims["iat"]
        actual_ttl = claims["exp"] - claims["iat"]
        assert actual_ttl == expected_ttl
