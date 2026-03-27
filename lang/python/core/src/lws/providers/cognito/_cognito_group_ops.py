"""Cognito user pool group operations mixin."""

from __future__ import annotations

import time
from typing import TYPE_CHECKING, Any

from lws.providers.cognito.user_store import CognitoError

if TYPE_CHECKING:
    from lws.providers.cognito.user_store import UserStore


class CognitoGroupOpsMixin:
    """Mixin providing group CRUD operations for CognitoProvider.

    Expects the host class to provide:
    - ``_validate_user_pool_id(user_pool_id)``
    - ``_store: UserStore``
    - ``_groups: dict[str, dict[str, Any]]``
    - ``_user_groups: dict[str, set[str]]``
    """

    _store: UserStore
    _groups: dict[str, dict[str, Any]]
    _user_groups: dict[str, set[str]]

    def _validate_user_pool_id(self, _user_pool_id: str) -> None: ...  # noqa: E704

    async def create_group(
        self,
        user_pool_id: str,
        group_name: str,
        description: str = "",
        precedence: int | None = None,
        role_arn: str | None = None,
    ) -> dict[str, Any]:
        """Create a new user pool group."""
        self._validate_user_pool_id(user_pool_id)
        if group_name in self._groups:
            raise CognitoError("GroupExistsException", f"Group '{group_name}' already exists.")
        group: dict[str, Any] = {
            "GroupName": group_name,
            "UserPoolId": user_pool_id,
            "Description": description,
            "CreationDate": time.time(),
            "LastModifiedDate": time.time(),
        }
        if precedence is not None:
            group["Precedence"] = precedence
        if role_arn is not None:
            group["RoleArn"] = role_arn
        self._groups[group_name] = group
        return {"Group": group}

    async def delete_group(self, user_pool_id: str, group_name: str) -> None:
        """Delete a user pool group."""
        self._validate_user_pool_id(user_pool_id)
        self._groups.pop(group_name, None)
        for memberships in self._user_groups.values():
            memberships.discard(group_name)

    async def admin_add_user_to_group(
        self, user_pool_id: str, username: str, group_name: str
    ) -> None:
        """Add a user to a group."""
        self._validate_user_pool_id(user_pool_id)
        if group_name not in self._groups:
            raise CognitoError("ResourceNotFoundException", f"Group '{group_name}' not found.")
        if username not in self._user_groups:
            self._user_groups[username] = set()
        self._user_groups[username].add(group_name)

    async def admin_remove_user_from_group(
        self, user_pool_id: str, username: str, group_name: str
    ) -> None:
        """Remove a user from a group."""
        self._validate_user_pool_id(user_pool_id)
        if group_name not in self._groups:
            raise CognitoError("ResourceNotFoundException", f"Group '{group_name}' not found.")
        if username in self._user_groups:
            self._user_groups[username].discard(group_name)

    async def list_groups(self, user_pool_id: str) -> dict[str, Any]:
        """List all groups in the user pool."""
        self._validate_user_pool_id(user_pool_id)
        return {"Groups": list(self._groups.values())}

    async def list_users_in_group(self, user_pool_id: str, group_name: str) -> dict[str, Any]:
        """List users belonging to a group."""
        self._validate_user_pool_id(user_pool_id)
        if group_name not in self._groups:
            raise CognitoError("ResourceNotFoundException", f"Group '{group_name}' not found.")
        members = [
            username for username, groups in self._user_groups.items() if group_name in groups
        ]
        users = []
        for username in members:
            user = await self._store.get_user(username)
            if user is not None:
                attrs_list = [{"Name": k, "Value": v} for k, v in user["attributes"].items()]
                attrs_list.append({"Name": "sub", "Value": user["sub"]})
                users.append(
                    {
                        "Username": user["username"],
                        "Attributes": attrs_list,
                        "UserStatus": "CONFIRMED" if user["confirmed"] else "UNCONFIRMED",
                        "Enabled": True,
                    }
                )
        return {"Users": users}
