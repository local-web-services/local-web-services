"""Admin user operation mixin for the Cognito UserStore."""

from __future__ import annotations

import json
import uuid

from lws.providers.cognito._cognito_auth import _hash_password, validate_password
from lws.providers.cognito._cognito_errors import (
    InvalidParameterException,
    NotAuthorizedException,
    UsernameExistsException,
    UserNotFoundException,
)


class _AdminUserOpsMixin:
    """Admin user operations mixin for UserStore.

    Assumes the host class provides:
      - self._conn: aiosqlite.Connection
      - self._config: UserPoolConfig
      - self._get_user_row(username) -> dict | None
      - self._check_username_available(username) -> None
    """

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
        assert self._conn is not None  # type: ignore[attr-defined]
        attributes = attributes or {}
        await self._check_username_available(username)  # type: ignore[attr-defined]
        password = temporary_password or uuid.uuid4().hex + "Aa1!"
        if temporary_password:
            validate_password(password, self._config.password_policy)  # type: ignore[attr-defined]
        sub = str(uuid.uuid4())
        pw_hash, pw_salt = _hash_password(password)
        await self._conn.execute(  # type: ignore[attr-defined]
            "INSERT INTO users (username, sub, password_hash, password_salt, confirmed, attributes)"
            " VALUES (?, ?, ?, ?, ?, ?)",
            (username, sub, pw_hash, pw_salt, 1, json.dumps(attributes)),
        )
        await self._conn.commit()  # type: ignore[attr-defined]
        return {"username": username, "sub": sub, "confirmed": True, "attributes": attributes}

    async def admin_delete_user(self, username: str) -> None:
        """Delete a user as an admin. Raises UserNotFoundException if not found."""
        assert self._conn is not None  # type: ignore[attr-defined]
        user = await self._get_user_row(username)  # type: ignore[attr-defined]
        if user is None:
            raise UserNotFoundException(username)
        await self._conn.execute("DELETE FROM users WHERE username = ?", (username,))  # type: ignore[attr-defined]
        await self._conn.commit()  # type: ignore[attr-defined]

    async def admin_get_user(self, username: str) -> dict:
        """Get user info as an admin. Raises UserNotFoundException if not found."""
        assert self._conn is not None  # type: ignore[attr-defined]
        user = await self._get_user_row(username)  # type: ignore[attr-defined]
        if user is None:
            raise UserNotFoundException(username)
        return {
            "username": user["username"],
            "sub": user["sub"],
            "confirmed": bool(user["confirmed"]),
            "enabled": bool(user["enabled"]),
            "attributes": json.loads(user["attributes"]),
            "reset_required": bool(user["reset_required"]),
        }

    async def list_users(self) -> list[dict]:
        """List all users in the user pool."""
        assert self._conn is not None  # type: ignore[attr-defined]
        cursor = await self._conn.execute(  # type: ignore[attr-defined]
            "SELECT username, sub, confirmed, attributes FROM users"
        )
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

    async def admin_confirm_user(self, username: str) -> None:
        """Confirm a user's account (admin). Raises UserNotFoundException if not found."""
        assert self._conn is not None  # type: ignore[attr-defined]
        user = await self._get_user_row(username)  # type: ignore[attr-defined]
        if user is None:
            raise UserNotFoundException(username)
        await self._conn.execute(  # type: ignore[attr-defined]
            "UPDATE users SET confirmed = 1 WHERE username = ?", (username,)
        )
        await self._conn.commit()  # type: ignore[attr-defined]

    async def admin_reset_user_password(self, username: str) -> None:
        """Set user to RESET_REQUIRED state so an admin can set a new password.

        Raises UserNotFoundException if not found,
        or NotAuthorizedException if the user is not confirmed.
        """
        assert self._conn is not None  # type: ignore[attr-defined]
        user = await self._get_user_row(username)  # type: ignore[attr-defined]
        if user is None:
            raise UserNotFoundException(username)
        if not user["confirmed"]:
            raise NotAuthorizedException("User is not confirmed.")
        await self._conn.execute(  # type: ignore[attr-defined]
            "UPDATE users SET reset_required = 1 WHERE username = ?", (username,)
        )
        await self._conn.commit()  # type: ignore[attr-defined]

    async def admin_set_user_password(
        self, username: str, password: str, permanent: bool = True
    ) -> None:
        """Set a user's password as an admin.

        Raises UserNotFoundException if not found,
        or InvalidPasswordException if the password fails policy.
        """
        assert self._conn is not None  # type: ignore[attr-defined]
        user = await self._get_user_row(username)  # type: ignore[attr-defined]
        if user is None:
            raise UserNotFoundException(username)
        validate_password(password, self._config.password_policy)  # type: ignore[attr-defined]
        pw_hash, pw_salt = _hash_password(password)
        confirmed = 1 if permanent else 0
        await self._conn.execute(  # type: ignore[attr-defined]
            "UPDATE users SET password_hash = ?, password_salt = ?, confirmed = ?,"
            " reset_required = 0 WHERE username = ?",
            (pw_hash, pw_salt, confirmed, username),
        )
        await self._conn.commit()  # type: ignore[attr-defined]

    async def admin_update_user_attributes(self, username: str, attributes: dict[str, str]) -> None:
        """Update user attributes as an admin. Raises UserNotFoundException if not found."""
        assert self._conn is not None  # type: ignore[attr-defined]
        user = await self._get_user_row(username)  # type: ignore[attr-defined]
        if user is None:
            raise UserNotFoundException(username)
        existing = json.loads(user["attributes"])
        existing.update(attributes)
        await self._conn.execute(  # type: ignore[attr-defined]
            "UPDATE users SET attributes = ? WHERE username = ?",
            (json.dumps(existing), username),
        )
        await self._conn.commit()  # type: ignore[attr-defined]

    async def admin_disable_user(self, username: str) -> None:
        """Disable a user account. Raises InvalidParameterException if already disabled."""
        assert self._conn is not None  # type: ignore[attr-defined]
        await self._set_user_enabled(username, False)

    async def admin_enable_user(self, username: str) -> None:
        """Enable a user account. Raises InvalidParameterException if already enabled."""
        assert self._conn is not None  # type: ignore[attr-defined]
        await self._set_user_enabled(username, True)

    async def _set_user_enabled(self, username: str, enabled: bool) -> None:
        user = await self._get_user_row(username)  # type: ignore[attr-defined]
        if user is None:
            raise UserNotFoundException(username)
        if bool(user["enabled"]) == enabled:
            state = "enabled" if enabled else "disabled"
            raise InvalidParameterException(f"User is already {state}.")
        await self._conn.execute(  # type: ignore[attr-defined]
            "UPDATE users SET enabled = ? WHERE username = ?", (int(enabled), username)
        )
        await self._conn.commit()  # type: ignore[attr-defined]


__all__ = ["_AdminUserOpsMixin", "UsernameExistsException"]
