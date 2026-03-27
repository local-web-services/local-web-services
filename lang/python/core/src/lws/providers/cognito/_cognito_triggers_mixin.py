"""Mixin providing Lambda trigger invocation for CognitoProvider."""

from __future__ import annotations

from typing import TYPE_CHECKING

from lws.providers.cognito._cognito_trigger_events import (
    build_post_confirmation_event as _build_post_confirmation_event,
)
from lws.providers.cognito._cognito_trigger_events import (
    build_pre_auth_event as _build_pre_auth_event,
)
from lws.providers.cognito.user_store import NotAuthorizedException

if TYPE_CHECKING:
    from lws.providers.cognito.provider import TriggerFunc
    from lws.providers.cognito.user_store import UserPoolConfig


class _CognitoTriggersMixin:
    """Mixin providing Lambda trigger invocation methods for CognitoProvider.

    Expects the host class to provide:
    - ``_config: UserPoolConfig``
    - ``_triggers: dict[str, TriggerFunc]``
    """

    _config: UserPoolConfig
    _triggers: dict[str, TriggerFunc]

    async def _invoke_pre_authentication(self, username: str) -> None:
        """Invoke the pre-authentication Lambda trigger if configured."""
        trigger_name = self._config.pre_authentication_trigger
        if not trigger_name or trigger_name not in self._triggers:
            return

        event = _build_pre_auth_event(
            username=username,
            user_pool_id=self._config.user_pool_id,
            client_id=self._config.client_id or "local-client-id",
        )

        trigger_fn = self._triggers[trigger_name]
        result = await trigger_fn(event)

        response = result.get("response", {})
        if not response:
            return
        # If the trigger explicitly denies, raise NotAuthorizedException
        if response.get("autoConfirmUser") is False:
            raise NotAuthorizedException("Pre-authentication denied by trigger.")

    async def _invoke_post_confirmation(
        self,
        username: str,
        sub: str,
        attributes: dict[str, str],
    ) -> None:
        """Invoke the post-confirmation Lambda trigger if configured."""
        trigger_name = self._config.post_confirmation_trigger
        if not trigger_name or trigger_name not in self._triggers:
            return

        event = _build_post_confirmation_event(
            username=username,
            sub=sub,
            attributes=attributes,
            user_pool_id=self._config.user_pool_id,
            client_id=self._config.client_id or "local-client-id",
        )

        trigger_fn = self._triggers[trigger_name]
        await trigger_fn(event)
