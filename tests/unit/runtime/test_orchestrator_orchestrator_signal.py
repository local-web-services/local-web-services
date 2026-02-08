"""Unit tests for the Orchestrator provider lifecycle manager."""

from __future__ import annotations

import pytest

from ._helpers import FakeProvider


@pytest.fixture
def orchestrator():
    from ldk.runtime.orchestrator import Orchestrator

    return Orchestrator()


class TestOrchestratorSignal:
    """Tests for signal-based shutdown."""

    async def test_wait_for_shutdown_unblocks_on_event(self, orchestrator):
        p = FakeProvider("test")
        await orchestrator.start({"p": p}, ["p"])

        # Manually set the stop event to simulate signal
        orchestrator._stop_event.set()
        await orchestrator.wait_for_shutdown()
        # Should return without hanging

    async def test_running_flag(self, orchestrator):
        assert not orchestrator.running
        p = FakeProvider("test")
        await orchestrator.start({"p": p}, ["p"])
        assert orchestrator.running
        await orchestrator.stop()
        assert not orchestrator.running
