"""Tests for Step Functions provider management operations."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions.provider import StepFunctionsProvider


@pytest.fixture()
async def provider() -> StepFunctionsProvider:
    p = StepFunctionsProvider()
    await p.start()
    yield p
    await p.stop()


class TestDeleteStateMachine:
    async def test_delete_removes_from_list(self, provider: StepFunctionsProvider) -> None:
        provider.create_state_machine(
            name="to-delete",
            definition='{"StartAt": "Pass", "States": {"Pass": {"Type": "Pass", "End": true}}}',
        )
        provider.delete_state_machine("to-delete")
        assert "to-delete" not in provider.list_state_machines()

    async def test_delete_nonexistent_raises(self, provider: StepFunctionsProvider) -> None:
        with pytest.raises(KeyError, match="State machine not found"):
            provider.delete_state_machine("nonexistent")
