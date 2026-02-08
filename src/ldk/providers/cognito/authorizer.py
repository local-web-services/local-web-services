"""Cognito JWT authorizer for API Gateway integration."""

from __future__ import annotations

from typing import Any

import jwt

from ldk.providers.cognito.tokens import TokenIssuer

# ---------------------------------------------------------------------------
# Authorizer
# ---------------------------------------------------------------------------


class CognitoAuthorizer:
    """Validates JWT tokens from the Authorization header.

    Integrates with API Gateway to pass decoded claims into
    ``event.requestContext.authorizer.claims``.

    Parameters
    ----------
    token_issuer : TokenIssuer
        The token issuer used for key material and validation.
    """

    def __init__(self, token_issuer: TokenIssuer) -> None:
        self._token_issuer = token_issuer

    def validate_token(self, authorization_header: str | None) -> dict[str, Any]:
        """Validate a Bearer token from the Authorization header.

        Returns the decoded claims dict on success.
        Raises AuthorizationError on failure.
        """
        if not authorization_header:
            raise AuthorizationError("Missing Authorization header")

        token = _extract_bearer_token(authorization_header)
        return self._decode_and_validate(token)

    def build_claims_context(self, claims: dict[str, Any]) -> dict[str, Any]:
        """Build the authorizer claims context for API Gateway event injection.

        Returns a dict suitable for ``event.requestContext.authorizer.claims``.
        """
        context: dict[str, Any] = {}
        for key in ("sub", "cognito:username", "email", "iss", "aud", "token_use"):
            if key in claims:
                context[key] = claims[key]
        # Convert numeric claims to strings as Cognito does
        for key in ("exp", "iat"):
            if key in claims:
                context[key] = str(claims[key])
        return context

    def _decode_and_validate(self, token: str) -> dict[str, Any]:
        """Decode a JWT and validate its claims."""
        try:
            claims = self._token_issuer.decode_token(token, token_use="id")
        except jwt.ExpiredSignatureError:
            raise AuthorizationError("Token has expired")
        except jwt.InvalidIssuerError:
            raise AuthorizationError("Invalid token issuer")
        except jwt.InvalidTokenError as exc:
            raise AuthorizationError(f"Invalid token: {exc}")
        return claims


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _extract_bearer_token(header: str) -> str:
    """Extract the token from a 'Bearer <token>' header value."""
    parts = header.split()
    if len(parts) != 2 or parts[0].lower() != "bearer":
        raise AuthorizationError("Invalid Authorization header format. Expected 'Bearer <token>'")
    return parts[1]


# ---------------------------------------------------------------------------
# Exceptions
# ---------------------------------------------------------------------------


class AuthorizationError(Exception):
    """Raised when JWT authorization fails."""

    def __init__(self, message: str) -> None:
        super().__init__(message)
        self.message = message
