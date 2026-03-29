"""Password hashing, validation, and configuration dataclasses for Cognito."""

from __future__ import annotations

import hashlib
import os
import re
from dataclasses import dataclass, field

from lws.providers.cognito._cognito_errors import InvalidPasswordException

# ---------------------------------------------------------------------------
# Configuration dataclasses
# ---------------------------------------------------------------------------


@dataclass
class PasswordPolicy:
    """Password policy configuration parsed from CDK UserPool config."""

    minimum_length: int = 8
    require_lowercase: bool = True
    require_uppercase: bool = True
    require_digits: bool = True
    require_symbols: bool = False


@dataclass
class UserPoolConfig:
    """Configuration for a Cognito User Pool."""

    user_pool_id: str
    user_pool_name: str = "default"
    password_policy: PasswordPolicy = field(default_factory=PasswordPolicy)
    required_attributes: list[str] = field(default_factory=list)
    auto_confirm: bool = True
    client_id: str = ""
    explicit_auth_flows: list[str] = field(default_factory=list)
    pre_authentication_trigger: str | None = None
    post_confirmation_trigger: str | None = None
    pre_signup_trigger: str | None = None


# ---------------------------------------------------------------------------
# Password hashing helpers
# ---------------------------------------------------------------------------

_HASH_ITERATIONS = 100_000
_HASH_ALGORITHM = "sha256"
_SALT_LENGTH = 16


def _hash_password(password: str, salt: bytes | None = None) -> tuple[str, str]:
    """Hash a password using PBKDF2-HMAC-SHA256.

    Returns (hex_hash, hex_salt).
    """
    if salt is None:
        salt = os.urandom(_SALT_LENGTH)
    dk = hashlib.pbkdf2_hmac(_HASH_ALGORITHM, password.encode(), salt, _HASH_ITERATIONS)
    return dk.hex(), salt.hex()


def _verify_password(password: str, stored_hash: str, stored_salt: str) -> bool:
    """Verify a password against a stored hash and salt."""
    computed_hash, _ = _hash_password(password, bytes.fromhex(stored_salt))
    return computed_hash == stored_hash


# ---------------------------------------------------------------------------
# Password policy validation
# ---------------------------------------------------------------------------


def _validate_password_length(password: str, policy: PasswordPolicy) -> str | None:
    """Check minimum length. Returns error message or None."""
    if len(password) < policy.minimum_length:
        return f"Password must be at least {policy.minimum_length} characters."
    return None


def _validate_password_chars(password: str, policy: PasswordPolicy) -> str | None:
    """Check character requirements. Returns error message or None."""
    if policy.require_lowercase and not re.search(r"[a-z]", password):
        return "Password must contain a lowercase letter."
    if policy.require_uppercase and not re.search(r"[A-Z]", password):
        return "Password must contain an uppercase letter."
    if policy.require_digits and not re.search(r"\d", password):
        return "Password must contain a digit."
    if policy.require_symbols and not re.search(r"[^a-zA-Z0-9]", password):
        return "Password must contain a symbol."
    return None


def validate_password(password: str, policy: PasswordPolicy) -> None:
    """Validate a password against the given policy. Raises InvalidPasswordException."""
    error = _validate_password_length(password, policy)
    if error:
        raise InvalidPasswordException(error)
    error = _validate_password_chars(password, policy)
    if error:
        raise InvalidPasswordException(error)
