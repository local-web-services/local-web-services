"""Tests for Cognito JWT authorizer."""

from __future__ import annotations

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


# ---------------------------------------------------------------------------
# Error Cases
# ---------------------------------------------------------------------------


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
