"""Presigned URL generation and validation for local S3 emulation.

Kept simple for local development -- uses HMAC-SHA256 with a local
signing key, just enough so that SDK-generated presigned URLs do not
break during local testing.
"""

from __future__ import annotations

import hashlib
import hmac
import time
from urllib.parse import parse_qs, urlencode, urlparse, urlunparse

_DEFAULT_SIGNING_KEY = "ldk-local-signing-key"


def generate_presigned_url(
    bucket: str,
    key: str,
    method: str = "GET",
    expires_in: int = 3600,
    signing_key: str | None = None,
    base_url: str = "http://localhost:4566",
) -> str:
    """Generate a presigned URL for an S3 object.

    Args:
        bucket: Bucket name.
        key: Object key.
        method: HTTP method (``GET`` or ``PUT``).
        expires_in: Seconds until the URL expires.
        signing_key: HMAC key. Falls back to a default local key.
        base_url: Base URL for the local S3 service.

    Returns:
        A fully-formed presigned URL string.
    """
    effective_key = signing_key or _DEFAULT_SIGNING_KEY
    expiration = int(time.time()) + expires_in

    path = f"/{bucket}/{key}"
    query_params = {
        "X-Amz-Algorithm": "LDK-HMAC-SHA256",
        "X-Amz-Expires": str(expires_in),
        "X-Amz-Date": str(expiration),
        "X-Amz-Method": method,
    }

    string_to_sign = _build_string_to_sign(method, path, expiration)
    signature = _compute_signature(string_to_sign, effective_key)
    query_params["X-Amz-Signature"] = signature

    parsed = urlparse(base_url)
    url = urlunparse(
        (
            parsed.scheme,
            parsed.netloc,
            path,
            "",
            urlencode(query_params),
            "",
        )
    )
    return url


def validate_presigned_url(url: str, signing_key: str | None = None) -> bool:
    """Validate a presigned URL's signature and expiration.

    Args:
        url: The full presigned URL to validate.
        signing_key: The HMAC key to verify against.

    Returns:
        ``True`` if the signature is valid and the URL has not expired.
    """
    effective_key = signing_key or _DEFAULT_SIGNING_KEY

    parsed = urlparse(url)
    params = parse_qs(parsed.query)

    signature = _first_param(params, "X-Amz-Signature")
    expiration_str = _first_param(params, "X-Amz-Date")
    method = _first_param(params, "X-Amz-Method")

    if not signature or not expiration_str or not method:
        return False

    try:
        expiration = int(expiration_str)
    except ValueError:
        return False

    # Check expiration
    if time.time() > expiration:
        return False

    # Verify signature
    string_to_sign = _build_string_to_sign(method, parsed.path, expiration)
    expected = _compute_signature(string_to_sign, effective_key)

    return hmac.compare_digest(signature, expected)


# ------------------------------------------------------------------
# Internal helpers
# ------------------------------------------------------------------


def _build_string_to_sign(method: str, path: str, expiration: int) -> str:
    """Build the canonical string to sign."""
    return f"{method}\n{path}\n{expiration}"


def _compute_signature(string_to_sign: str, key: str) -> str:
    """Compute HMAC-SHA256 signature."""
    return hmac.new(
        key.encode("utf-8"),
        string_to_sign.encode("utf-8"),
        hashlib.sha256,
    ).hexdigest()


def _first_param(params: dict, name: str) -> str | None:
    """Extract the first value for a query parameter, or None."""
    values = params.get(name, [])
    return values[0] if values else None
