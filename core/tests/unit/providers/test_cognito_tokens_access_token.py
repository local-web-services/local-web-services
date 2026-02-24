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
        # Arrange
        expected_sub = "sub-123"
        expected_username = "alice"
        expected_token_use = "access"

        # Act
        token = issuer.issue_access_token(expected_sub, expected_username)
        claims = issuer.decode_token(token, token_use=expected_token_use)

        # Assert
        actual_sub = claims["sub"]
        actual_username = claims["cognito:username"]
        actual_token_use = claims["token_use"]
        assert actual_sub == expected_sub
        assert actual_username == expected_username
        assert actual_token_use == expected_token_use

    def test_access_token_has_scope(self, issuer: TokenIssuer) -> None:
        # Act
        token = issuer.issue_access_token("sub-123", "alice")
        claims = issuer.decode_token(token, token_use="access")

        # Assert
        assert "scope" in claims

    def test_access_token_has_client_id(self, issuer: TokenIssuer) -> None:
        # Act
        token = issuer.issue_access_token("sub-123", "alice")
        claims = issuer.decode_token(token, token_use="access")

        # Assert
        expected_client_id = "test-client-id"
        actual_client_id = claims["client_id"]
        assert actual_client_id == expected_client_id
