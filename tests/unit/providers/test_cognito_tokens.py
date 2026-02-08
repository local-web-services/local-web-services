"""Tests for Cognito token issuance and JWKS."""

from __future__ import annotations

import jwt
import pytest

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


# ---------------------------------------------------------------------------
# JWKS Tests
# ---------------------------------------------------------------------------


class TestJWKS:
    """JWKS endpoint payload."""

    def test_jwks_has_keys(self, issuer: TokenIssuer) -> None:
        jwks = issuer.get_jwks()
        assert "keys" in jwks
        assert len(jwks["keys"]) == 1

    def test_jwk_structure(self, issuer: TokenIssuer) -> None:
        jwk = issuer.get_jwks()["keys"][0]
        assert jwk["kty"] == "RSA"
        assert jwk["alg"] == "RS256"
        assert jwk["use"] == "sig"
        assert "kid" in jwk
        assert "n" in jwk
        assert "e" in jwk


# ---------------------------------------------------------------------------
# ID Token Tests
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


# ---------------------------------------------------------------------------
# Access Token Tests
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


# ---------------------------------------------------------------------------
# Refresh Token Tests
# ---------------------------------------------------------------------------


class TestRefreshToken:
    """Refresh token generation."""

    def test_refresh_token_is_string(self, issuer: TokenIssuer) -> None:
        token = issuer.generate_refresh_token()
        assert isinstance(token, str)
        assert len(token) > 0

    def test_refresh_tokens_are_unique(self, issuer: TokenIssuer) -> None:
        t1 = issuer.generate_refresh_token()
        t2 = issuer.generate_refresh_token()
        assert t1 != t2


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
        token = issuer.issue_id_token("sub-123", "alice", {})
        # Decode header to verify algorithm
        header = jwt.get_unverified_header(token)
        assert header["alg"] == "RS256"
        assert "kid" in header
