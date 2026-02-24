"""SQLite-backed user store for the Cognito provider."""

from __future__ import annotations

import hashlib
import json
import os
import random
import re
import time
import uuid
from dataclasses import dataclass, field
from pathlib import Path

import aiosqlite

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


# ---------------------------------------------------------------------------
# Exceptions
# ---------------------------------------------------------------------------


class CognitoError(Exception):
    """Base Cognito exception with an error code."""

    def __init__(self, code: str, message: str) -> None:
        super().__init__(message)
        self.code = code


class UsernameExistsException(CognitoError):
    """Raised when a username is already taken."""

    def __init__(self, username: str) -> None:
        super().__init__("UsernameExistsException", f"User already exists: {username}")


class InvalidPasswordException(CognitoError):
    """Raised when a password does not meet policy requirements."""

    def __init__(self, message: str) -> None:
        super().__init__("InvalidPasswordException", message)


class InvalidParameterException(CognitoError):
    """Raised when a required attribute is missing."""

    def __init__(self, message: str) -> None:
        super().__init__("InvalidParameterException", message)


class NotAuthorizedException(CognitoError):
    """Raised when credentials are invalid."""

    def __init__(self, message: str = "Incorrect username or password.") -> None:
        super().__init__("NotAuthorizedException", message)


class UserNotConfirmedException(CognitoError):
    """Raised when a user has not confirmed their account."""

    def __init__(self) -> None:
        super().__init__("UserNotConfirmedException", "User is not confirmed.")


class UserNotFoundException(CognitoError):
    """Raised when a user is not found."""

    def __init__(self, username: str) -> None:
        super().__init__("UserNotFoundException", f"User does not exist: {username}")


class ExpiredCodeException(CognitoError):
    """Raised when a confirmation code has expired."""

    def __init__(self) -> None:
        super().__init__("ExpiredCodeException", "Confirmation code has expired.")


class CodeMismatchException(CognitoError):
    """Raised when a confirmation code does not match."""

    def __init__(self) -> None:
        super().__init__("CodeMismatchException", "Invalid verification code provided.")


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


# ---------------------------------------------------------------------------
# UserStore
# ---------------------------------------------------------------------------


class UserStore:
    """SQLite-backed Cognito user store.

    Provides async methods for user sign-up, confirmation, and authentication.

    Parameters
    ----------
    data_dir : Path
        Directory for storing the SQLite database file.
    config : UserPoolConfig
        User pool configuration including password policy.
    """

    def __init__(self, data_dir: Path, config: UserPoolConfig) -> None:
        self._data_dir = data_dir
        self._config = config
        self._conn: aiosqlite.Connection | None = None

    @property
    def config(self) -> UserPoolConfig:
        """Return the user pool configuration."""
        return self._config

    async def start(self) -> None:
        """Open the SQLite database and create the users table."""
        db_dir = self._data_dir / "cognito"
        db_dir.mkdir(parents=True, exist_ok=True)
        db_path = db_dir / f"{self._config.user_pool_id}.db"
        self._conn = await aiosqlite.connect(str(db_path))
        await self._conn.execute("PRAGMA journal_mode=WAL")
        await self._conn.execute(
            "CREATE TABLE IF NOT EXISTS users ("
            "  username TEXT PRIMARY KEY,"
            "  sub TEXT NOT NULL,"
            "  password_hash TEXT NOT NULL,"
            "  password_salt TEXT NOT NULL,"
            "  confirmed INTEGER NOT NULL DEFAULT 0,"
            "  attributes TEXT NOT NULL DEFAULT '{}'"
            ")"
        )
        await self._conn.execute(
            "CREATE TABLE IF NOT EXISTS refresh_tokens ("
            "  token TEXT PRIMARY KEY,"
            "  username TEXT NOT NULL,"
            "  created_at REAL NOT NULL"
            ")"
        )
        await self._conn.execute(
            "CREATE TABLE IF NOT EXISTS password_reset_codes ("
            "  username TEXT PRIMARY KEY,"
            "  code TEXT NOT NULL,"
            "  expires_at REAL NOT NULL"
            ")"
        )
        await self._conn.commit()

    async def stop(self) -> None:
        """Close the SQLite database."""
        if self._conn is not None:
            await self._conn.close()
            self._conn = None

    async def is_healthy(self) -> bool:
        """Check if the database connection is active."""
        return self._conn is not None

    async def sign_up(
        self,
        username: str,
        password: str,
        attributes: dict[str, str] | None = None,
    ) -> str:
        """Register a new user. Returns the user's sub (UUID).

        Raises UsernameExistsException, InvalidPasswordException,
        or InvalidParameterException.
        """
        assert self._conn is not None
        attributes = attributes or {}

        await self._check_username_available(username)
        validate_password(password, self._config.password_policy)
        self._validate_required_attributes(attributes)

        sub = str(uuid.uuid4())
        pw_hash, pw_salt = _hash_password(password)
        confirmed = 1 if self._config.auto_confirm else 0

        await self._conn.execute(
            "INSERT INTO users (username, sub, password_hash, password_salt, confirmed, attributes)"
            " VALUES (?, ?, ?, ?, ?, ?)",
            (username, sub, pw_hash, pw_salt, confirmed, json.dumps(attributes)),
        )
        await self._conn.commit()
        return sub

    async def confirm_sign_up(self, username: str) -> None:
        """Confirm a user's account."""
        assert self._conn is not None
        user = await self._get_user_row(username)
        if user is None:
            raise UserNotFoundException(username)
        await self._conn.execute(
            "UPDATE users SET confirmed = 1 WHERE username = ?",
            (username,),
        )
        await self._conn.commit()

    async def authenticate(self, username: str, password: str) -> dict:
        """Authenticate a user. Returns user info dict.

        Raises NotAuthorizedException or UserNotConfirmedException.
        """
        assert self._conn is not None
        user = await self._get_user_row(username)
        if user is None:
            raise NotAuthorizedException()

        stored_hash = user["password_hash"]
        stored_salt = user["password_salt"]
        if not _verify_password(password, stored_hash, stored_salt):
            raise NotAuthorizedException()

        if not user["confirmed"]:
            raise UserNotConfirmedException()

        return {
            "username": user["username"],
            "sub": user["sub"],
            "attributes": json.loads(user["attributes"]),
        }

    async def get_user(self, username: str) -> dict | None:
        """Get user info by username. Returns None if not found."""
        assert self._conn is not None
        user = await self._get_user_row(username)
        if user is None:
            return None
        return {
            "username": user["username"],
            "sub": user["sub"],
            "confirmed": bool(user["confirmed"]),
            "attributes": json.loads(user["attributes"]),
        }

    async def store_refresh_token(self, token: str, username: str, created_at: float) -> None:
        """Store a refresh token."""
        assert self._conn is not None
        await self._conn.execute(
            "INSERT OR REPLACE INTO refresh_tokens (token, username, created_at) VALUES (?, ?, ?)",
            (token, username, created_at),
        )
        await self._conn.commit()

    async def get_refresh_token_username(self, token: str) -> str | None:
        """Look up the username associated with a refresh token."""
        assert self._conn is not None
        cursor = await self._conn.execute(
            "SELECT username FROM refresh_tokens WHERE token = ?",
            (token,),
        )
        row = await cursor.fetchone()
        return row[0] if row else None

    async def admin_create_user(
        self,
        username: str,
        temporary_password: str | None = None,
        attributes: dict[str, str] | None = None,
    ) -> dict:
        """Create a user as an admin. Returns user info dict.

        The user is created as confirmed. If no temporary password is provided,
        a random one is generated.

        Raises UsernameExistsException.
        """
        assert self._conn is not None
        attributes = attributes or {}

        await self._check_username_available(username)

        password = temporary_password or uuid.uuid4().hex + "Aa1!"
        if temporary_password:
            validate_password(password, self._config.password_policy)

        sub = str(uuid.uuid4())
        pw_hash, pw_salt = _hash_password(password)

        await self._conn.execute(
            "INSERT INTO users (username, sub, password_hash, password_salt, confirmed, attributes)"
            " VALUES (?, ?, ?, ?, ?, ?)",
            (username, sub, pw_hash, pw_salt, 1, json.dumps(attributes)),
        )
        await self._conn.commit()
        return {
            "username": username,
            "sub": sub,
            "confirmed": True,
            "attributes": attributes,
        }

    async def admin_delete_user(self, username: str) -> None:
        """Delete a user as an admin.

        Raises UserNotFoundException if the user does not exist.
        """
        assert self._conn is not None
        user = await self._get_user_row(username)
        if user is None:
            raise UserNotFoundException(username)
        await self._conn.execute("DELETE FROM users WHERE username = ?", (username,))
        await self._conn.commit()

    async def admin_get_user(self, username: str) -> dict:
        """Get user info as an admin.

        Raises UserNotFoundException if the user does not exist.
        """
        assert self._conn is not None
        user = await self._get_user_row(username)
        if user is None:
            raise UserNotFoundException(username)
        return {
            "username": user["username"],
            "sub": user["sub"],
            "confirmed": bool(user["confirmed"]),
            "attributes": json.loads(user["attributes"]),
        }

    async def list_users(self) -> list[dict]:
        """List all users in the user pool."""
        assert self._conn is not None
        cursor = await self._conn.execute("SELECT username, sub, confirmed, attributes FROM users")
        rows = await cursor.fetchall()
        return [
            {
                "username": row[0],
                "sub": row[1],
                "confirmed": bool(row[2]),
                "attributes": json.loads(row[3]),
            }
            for row in rows
        ]

    # -- Password reset --------------------------------------------------------

    async def create_password_reset_code(self, username: str) -> str:
        """Generate and store a 6-digit password reset code.

        Returns the code. Raises UserNotFoundException if user does not exist.
        """
        assert self._conn is not None
        user = await self._get_user_row(username)
        if user is None:
            raise UserNotFoundException(username)
        code = f"{random.randint(0, 999999):06d}"  # noqa: S311
        expires_at = time.time() + 300  # 5 minutes
        await self._conn.execute(
            "INSERT OR REPLACE INTO password_reset_codes (username, code, expires_at)"
            " VALUES (?, ?, ?)",
            (username, code, expires_at),
        )
        await self._conn.commit()
        return code

    async def confirm_password_reset(self, username: str, code: str, new_password: str) -> None:
        """Validate reset code and update password.

        Raises ExpiredCodeException or CodeMismatchException on failure.
        """
        assert self._conn is not None
        cursor = await self._conn.execute(
            "SELECT code, expires_at FROM password_reset_codes WHERE username = ?",
            (username,),
        )
        row = await cursor.fetchone()
        if row is None:
            raise CodeMismatchException()
        stored_code, expires_at = row[0], row[1]
        if time.time() > expires_at:
            await self._conn.execute(
                "DELETE FROM password_reset_codes WHERE username = ?", (username,)
            )
            await self._conn.commit()
            raise ExpiredCodeException()
        if stored_code != code:
            raise CodeMismatchException()
        validate_password(new_password, self._config.password_policy)
        pw_hash, pw_salt = _hash_password(new_password)
        await self._conn.execute(
            "UPDATE users SET password_hash = ?, password_salt = ? WHERE username = ?",
            (pw_hash, pw_salt, username),
        )
        await self._conn.execute("DELETE FROM password_reset_codes WHERE username = ?", (username,))
        await self._conn.commit()

    async def change_password(self, username: str, old_password: str, new_password: str) -> None:
        """Change a user's password after verifying the old password.

        Raises NotAuthorizedException if old password is wrong.
        """
        assert self._conn is not None
        user = await self._get_user_row(username)
        if user is None:
            raise NotAuthorizedException("User not found.")
        if not _verify_password(old_password, user["password_hash"], user["password_salt"]):
            raise NotAuthorizedException("Incorrect username or password.")
        validate_password(new_password, self._config.password_policy)
        pw_hash, pw_salt = _hash_password(new_password)
        await self._conn.execute(
            "UPDATE users SET password_hash = ?, password_salt = ? WHERE username = ?",
            (pw_hash, pw_salt, username),
        )
        await self._conn.commit()

    async def revoke_refresh_tokens(self, username: str) -> None:
        """Delete all refresh tokens for a user."""
        assert self._conn is not None
        await self._conn.execute("DELETE FROM refresh_tokens WHERE username = ?", (username,))
        await self._conn.commit()

    # -- Private helpers -------------------------------------------------------

    async def _check_username_available(self, username: str) -> None:
        """Raise UsernameExistsException if username is taken."""
        assert self._conn is not None
        cursor = await self._conn.execute("SELECT 1 FROM users WHERE username = ?", (username,))
        if await cursor.fetchone():
            raise UsernameExistsException(username)

    def _validate_required_attributes(self, attributes: dict[str, str]) -> None:
        """Raise InvalidParameterException if required attributes are missing."""
        for attr in self._config.required_attributes:
            if attr not in attributes:
                raise InvalidParameterException(f"Missing required attribute: {attr}")

    async def _get_user_row(self, username: str) -> dict | None:
        """Fetch a user row as a dict."""
        assert self._conn is not None
        cursor = await self._conn.execute(
            "SELECT username, sub, password_hash, password_salt, confirmed, attributes "
            "FROM users WHERE username = ?",
            (username,),
        )
        row = await cursor.fetchone()
        if row is None:
            return None
        return {
            "username": row[0],
            "sub": row[1],
            "password_hash": row[2],
            "password_salt": row[3],
            "confirmed": row[4],
            "attributes": row[5],
        }
