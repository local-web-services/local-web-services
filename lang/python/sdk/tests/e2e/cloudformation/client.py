"""Test client for cloudformation tests."""

from __future__ import annotations

from .constants import TEST_STACK_NAME


class CloudformationTestClient:
    def __init__(self, lws_session):
        self._session = lws_session
        self._client = lws_session.client("cloudformation")

    def __getattr__(self, name: str):
        return getattr(self._client, name)

    def create_stack(self, stack_name=TEST_STACK_NAME):
        try:
            self._client.create_stack(StackName=stack_name)
        except Exception:
            pass
