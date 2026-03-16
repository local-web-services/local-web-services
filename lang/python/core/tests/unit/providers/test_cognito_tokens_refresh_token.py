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
