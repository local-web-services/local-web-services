"""Tests for Cognito token issuance and JWKS."""

from __future__ import annotations

import jwt
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


class TestTokenValidation:
    """Token validation error cases."""

    def test_tampered_token_rejected(self, issuer: TokenIssuer) -> None:
        token = issuer.issue_id_token("sub-123", "alice", {})
        # Tamper by changing a character
        tampered = token[:-5] + "XXXXX"
        with pytest.raises(jwt.InvalidTokenError):
            issuer.decode_token(tampered, token_use="id")

    def test_wrong_issuer_rejected(self, issuer: TokenIssuer) -> None:
        # Create a different issuer and try to validate the token
        other_issuer = TokenIssuer(
            user_pool_id="us-east-1_OtherPool",
            client_id="test-client-id",
        )
        token = other_issuer.issue_id_token("sub-123", "alice", {})
        with pytest.raises(jwt.InvalidTokenError):
            issuer.decode_token(token, token_use="id")

    def test_rs256_algorithm(self, issuer: TokenIssuer) -> None:
        # Act
        token = issuer.issue_id_token("sub-123", "alice", {})
        header = jwt.get_unverified_header(token)

        # Assert
        expected_alg = "RS256"
        actual_alg = header["alg"]
        assert actual_alg == expected_alg
        assert "kid" in header
