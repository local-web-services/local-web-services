"""Unit tests for the Orchestrator provider lifecycle manager."""

from __future__ import annotations

import pytest

from ldk.interfaces.provider import ProviderStartError

from ._helpers import FakeProvider


@pytest.fixture
def orchestrator():
    from ldk.runtime.orchestrator import Orchestrator

    return Orchestrator()


class TestOrchestratorFailure:
    """Tests for failure during start."""

    async def test_failed_provider_triggers_shutdown(self, orchestrator):
        p1 = FakeProvider("good")
        p2 = FakeProvider("bad", fail_start=True)

        with pytest.raises(ProviderStartError, match="bad"):
            await orchestrator.start(
                {"p1": p1, "p2": p2},
                ["p1", "p2"],
            )

        # p1 should have been stopped during cleanup
        assert p1.stopped

    async def test_skips_missing_providers_in_startup_order(self, orchestrator):
        p1 = FakeProvider("existing")
        # startup_order references a node that has no provider
        await orchestrator.start(
            {"p1": p1},
            ["nonexistent", "p1"],
        )
        assert p1.started
        assert orchestrator.running
