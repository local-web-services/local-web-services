"""Cognito group operation route handlers mixin."""

from __future__ import annotations

from typing import TYPE_CHECKING

from fastapi import Response

from lws.providers.cognito._cognito_routes_helpers import json_response as _json_response

if TYPE_CHECKING:
    from lws.providers.cognito.provider import CognitoProvider


class _CognitoGroupRoutesMixin:
    """Mixin providing group operation route handlers for CognitoRouter.

    Expects the host class to provide:
    - ``_provider: CognitoProvider``
    - ``_check_pool_state(user_pool_id) -> Response | None``
    """

    _provider: CognitoProvider

    def _check_pool_state(
        self, _pool_id: str
    ) -> Response | None:  # pylint: disable=unused-argument
        raise NotImplementedError

    async def _create_group(self, body: dict) -> Response:
        """Handle CreateGroup operation."""
        group_name = body.get("GroupName", "")
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        description = body.get("Description", "")
        precedence = body.get("Precedence")
        role_arn = body.get("RoleArn")
        result = await self._provider.create_group(
            user_pool_id, group_name, description, precedence, role_arn
        )
        return _json_response(result)

    async def _delete_group(self, body: dict) -> Response:
        """Handle DeleteGroup operation."""
        group_name = body.get("GroupName", "")
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        await self._provider.delete_group(user_pool_id, group_name)
        return _json_response({})

    async def _admin_add_user_to_group(self, body: dict) -> Response:
        """Handle AdminAddUserToGroup operation."""
        group_name = body.get("GroupName", "")
        username = body.get("Username", "")
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        await self._provider.admin_add_user_to_group(user_pool_id, username, group_name)
        return _json_response({})

    async def _admin_remove_user_from_group(self, body: dict) -> Response:
        """Handle AdminRemoveUserFromGroup operation."""
        group_name = body.get("GroupName", "")
        username = body.get("Username", "")
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        await self._provider.admin_remove_user_from_group(user_pool_id, username, group_name)
        return _json_response({})

    async def _list_groups(self, body: dict) -> Response:
        """Handle ListGroups operation."""
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        result = await self._provider.list_groups(user_pool_id)
        return _json_response(result)

    async def _list_users_in_group(self, body: dict) -> Response:
        """Handle ListUsersInGroup operation."""
        group_name = body.get("GroupName", "")
        user_pool_id = body.get("UserPoolId", "")
        err = self._check_pool_state(user_pool_id)
        if err is not None:
            return err
        result = await self._provider.list_users_in_group(user_pool_id, group_name)
        return _json_response(result)
