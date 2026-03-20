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
        assert "keys" in jwks, f'Expected {"keys"!r} to be in {jwks!r}'
        assert len(jwks["keys"]) == 1, f'Expected {1!r} but got {len(jwks["keys"])!r}'

    def test_jwk_structure(self, issuer: TokenIssuer) -> None:
        # Act
        jwk = issuer.get_jwks()["keys"][0]

        # Assert
        expected_kty = "RSA"
        expected_alg = "RS256"
        expected_use = "sig"
        assert jwk["kty"] == expected_kty, f'Expected {expected_kty!r} but got {jwk["kty"]!r}'
        assert jwk["alg"] == expected_alg, f'Expected {expected_alg!r} but got {jwk["alg"]!r}'
        assert jwk["use"] == expected_use, f'Expected {expected_use!r} but got {jwk["use"]!r}'
        assert "kid" in jwk, f'Expected {"kid"!r} to be in {jwk!r}'
        assert "n" in jwk, f'Expected {"n"!r} to be in {jwk!r}'
        assert "e" in jwk, f'Expected {"e"!r} to be in {jwk!r}'
