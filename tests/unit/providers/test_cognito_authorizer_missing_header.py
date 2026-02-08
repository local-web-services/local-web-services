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


class TestMissingHeader:
    """Missing or malformed Authorization header."""

    def test_missing_header(self, authorizer: CognitoAuthorizer) -> None:
        with pytest.raises(AuthorizationError, match="Missing"):
            authorizer.validate_token(None)

    def test_empty_header(self, authorizer: CognitoAuthorizer) -> None:
        with pytest.raises(AuthorizationError, match="Missing"):
            authorizer.validate_token("")

    def test_no_bearer_prefix(self, authorizer: CognitoAuthorizer) -> None:
        with pytest.raises(AuthorizationError, match="Invalid Authorization"):
            authorizer.validate_token("Token xyz")

    def test_bare_token(self, authorizer: CognitoAuthorizer) -> None:
        with pytest.raises(AuthorizationError, match="Invalid Authorization"):
            authorizer.validate_token("just-a-token")
