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


class TestJWKS:
    """JWKS endpoint payload."""

    def test_jwks_has_keys(self, issuer: TokenIssuer) -> None:
        jwks = issuer.get_jwks()
        assert "keys" in jwks
        assert len(jwks["keys"]) == 1

    def test_jwk_structure(self, issuer: TokenIssuer) -> None:
        # Act
        jwk = issuer.get_jwks()["keys"][0]

        # Assert
        expected_kty = "RSA"
        expected_alg = "RS256"
        expected_use = "sig"
        assert jwk["kty"] == expected_kty
        assert jwk["alg"] == expected_alg
        assert jwk["use"] == expected_use
        assert "kid" in jwk
        assert "n" in jwk
        assert "e" in jwk
