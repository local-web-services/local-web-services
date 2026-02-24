"""JWT token generation and JWKS for the Cognito provider."""

from __future__ import annotations

import base64
import time
import uuid
from typing import Any

import jwt
from cryptography.hazmat.primitives.asymmetric import rsa
from cryptography.hazmat.primitives.serialization import (
    Encoding,
    NoEncryption,
    PrivateFormat,
    PublicFormat,
)

# ---------------------------------------------------------------------------
# RSA key helpers
# ---------------------------------------------------------------------------

_KEY_SIZE = 2048
_PUBLIC_EXPONENT = 65537


def _generate_rsa_key_pair() -> tuple[rsa.RSAPrivateKey, rsa.RSAPublicKey]:
    """Generate an ephemeral RSA key pair."""
    private_key = rsa.generate_private_key(
        public_exponent=_PUBLIC_EXPONENT,
        key_size=_KEY_SIZE,
    )
    public_key = private_key.public_key()
    return private_key, public_key


def _int_to_base64url(value: int, length: int) -> str:
    """Convert an integer to a base64url-encoded string."""
    value_bytes = value.to_bytes(length, byteorder="big")
    return base64.urlsafe_b64encode(value_bytes).rstrip(b"=").decode("ascii")


def _build_jwk(public_key: rsa.RSAPublicKey, kid: str) -> dict[str, str]:
    """Build a JWK dict from an RSA public key."""
    pub_numbers = public_key.public_numbers()
    n_bytes = (pub_numbers.n.bit_length() + 7) // 8
    return {
        "kty": "RSA",
        "kid": kid,
        "use": "sig",
        "alg": "RS256",
        "n": _int_to_base64url(pub_numbers.n, n_bytes),
        "e": _int_to_base64url(pub_numbers.e, 3),
    }


# ---------------------------------------------------------------------------
# Token configuration
# ---------------------------------------------------------------------------

_ID_TOKEN_EXPIRY = 3600  # 1 hour
_ACCESS_TOKEN_EXPIRY = 3600  # 1 hour


# ---------------------------------------------------------------------------
# TokenIssuer
# ---------------------------------------------------------------------------


class TokenIssuer:
    """Generates and validates JWT tokens for a Cognito user pool.

    Uses RS256 signing with an ephemeral RSA key pair. Provides a JWKS
    endpoint payload for token verification.

    Parameters
    ----------
    user_pool_id : str
        The user pool ID used in the issuer claim.
    client_id : str
        The app client ID used in the audience claim.
    region : str
        The AWS region for constructing the issuer URL.
    """

    def __init__(
        self,
        user_pool_id: str,
        client_id: str,
        region: str = "us-east-1",
    ) -> None:
        self._user_pool_id = user_pool_id
        self._client_id = client_id
        self._region = region
        self._kid = str(uuid.uuid4())
        self._private_key, self._public_key = _generate_rsa_key_pair()
        self._issuer = f"https://cognito-idp.{region}.amazonaws.com/{user_pool_id}"

    @property
    def issuer(self) -> str:
        """Return the token issuer URL."""
        return self._issuer

    @property
    def client_id(self) -> str:
        """Return the client ID."""
        return self._client_id

    def get_jwks(self) -> dict[str, list[dict[str, str]]]:
        """Return the JWKS payload containing the public key."""
        jwk = _build_jwk(self._public_key, self._kid)
        return {"keys": [jwk]}

    def issue_id_token(self, sub: str, username: str, attributes: dict[str, str]) -> str:
        """Issue an ID token with standard Cognito claims."""
        now = int(time.time())
        claims = _build_id_claims(
            sub=sub,
            username=username,
            attributes=attributes,
            issuer=self._issuer,
            client_id=self._client_id,
            now=now,
        )
        return self._sign(claims)

    def issue_access_token(self, sub: str, username: str) -> str:
        """Issue an access token with standard Cognito claims."""
        now = int(time.time())
        claims = _build_access_claims(
            sub=sub,
            username=username,
            issuer=self._issuer,
            client_id=self._client_id,
            now=now,
        )
        return self._sign(claims)

    def generate_refresh_token(self) -> str:
        """Generate a random refresh token string."""
        return str(uuid.uuid4())

    def get_public_key_pem(self) -> bytes:
        """Return the public key in PEM format for verification."""
        return self._public_key.public_bytes(
            encoding=Encoding.PEM,
            format=PublicFormat.SubjectPublicKeyInfo,
        )

    def get_private_key_pem(self) -> bytes:
        """Return the private key in PEM format."""
        return self._private_key.private_bytes(
            encoding=Encoding.PEM,
            format=PrivateFormat.PKCS8,
            encryption_algorithm=NoEncryption(),
        )

    def decode_token(self, token: str, token_use: str = "id") -> dict[str, Any]:
        """Decode and validate a JWT token.

        Raises jwt.InvalidTokenError on any validation failure.
        """
        return jwt.decode(
            token,
            self.get_public_key_pem(),
            algorithms=["RS256"],
            issuer=self._issuer,
            audience=self._client_id if token_use == "id" else None,
            options=_decode_options(token_use),
        )

    def _sign(self, claims: dict[str, Any]) -> str:
        """Sign claims with RS256."""
        return jwt.encode(
            claims,
            self.get_private_key_pem(),
            algorithm="RS256",
            headers={"kid": self._kid},
        )


# ---------------------------------------------------------------------------
# Claim builders
# ---------------------------------------------------------------------------


def _build_id_claims(
    sub: str,
    username: str,
    attributes: dict[str, str],
    issuer: str,
    client_id: str,
    now: int,
) -> dict[str, Any]:
    """Build the claims dict for an ID token."""
    claims: dict[str, Any] = {
        "sub": sub,
        "cognito:username": username,
        "iss": issuer,
        "aud": client_id,
        "exp": now + _ID_TOKEN_EXPIRY,
        "iat": now,
        "token_use": "id",
    }
    if "email" in attributes:
        claims["email"] = attributes["email"]
    return claims


def _build_access_claims(
    sub: str,
    username: str,
    issuer: str,
    client_id: str,
    now: int,
) -> dict[str, Any]:
    """Build the claims dict for an access token."""
    return {
        "sub": sub,
        "cognito:username": username,
        "iss": issuer,
        "client_id": client_id,
        "scope": "aws.cognito.signin.user.admin",
        "exp": now + _ACCESS_TOKEN_EXPIRY,
        "iat": now,
        "token_use": "access",
    }


def _decode_options(token_use: str) -> dict[str, bool]:
    """Build decode options based on token use."""
    opts: dict[str, bool] = {"verify_exp": True, "verify_iss": True}
    if token_use == "access":
        opts["verify_aud"] = False
    return opts
