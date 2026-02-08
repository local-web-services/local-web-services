"""Unit tests for the Orchestrator provider lifecycle manager."""

from __future__ import annotations

import pytest

from ldk.interfaces.provider import Provider, ProviderStartError, ProviderStatus


class FakeProvider(Provider):
    """Minimal Provider implementation for testing."""

    def __init__(self, provider_name: str, fail_start: bool = False) -> None:
        self._name = provider_name
        self._status = ProviderStatus.STOPPED
        self._fail_start = fail_start
        self.started = False
        self.stopped = False
        self.start_order: int = -1
        self.stop_order: int = -1

    @property
    def name(self) -> str:
        return self._name

    async def start(self) -> None:
        if self._fail_start:
            raise RuntimeError(f"{self._name} failed to start")
        self._status = ProviderStatus.RUNNING
        self.started = True

    async def stop(self) -> None:
        self._status = ProviderStatus.STOPPED
        self.stopped = True

    async def health_check(self) -> bool:
        return self._status is ProviderStatus.RUNNING


@pytest.fixture
def orchestrator():
    from ldk.runtime.orchestrator import Orchestrator

    return Orchestrator()


class TestOrchestratorStartStop:
    """Tests for start and stop lifecycle."""

    async def test_start_single_provider(self, orchestrator):
        p = FakeProvider("test-provider")
        await orchestrator.start({"p1": p}, ["p1"])
        assert p.started
        assert orchestrator.running

    async def test_start_multiple_providers_in_order(self, orchestrator):
        counter = {"value": 0}
        p1 = FakeProvider("first")
        p2 = FakeProvider("second")
        p3 = FakeProvider("third")

        original_start_p1 = p1.start
        original_start_p2 = p2.start
        original_start_p3 = p3.start

        async def track_start_p1():
            await original_start_p1()
            p1.start_order = counter["value"]
            counter["value"] += 1

        async def track_start_p2():
            await original_start_p2()
            p2.start_order = counter["value"]
            counter["value"] += 1

        async def track_start_p3():
            await original_start_p3()
            p3.start_order = counter["value"]
            counter["value"] += 1

        p1.start = track_start_p1
        p2.start = track_start_p2
        p3.start = track_start_p3

        await orchestrator.start(
            {"p1": p1, "p2": p2, "p3": p3},
            ["p1", "p2", "p3"],
        )

        assert p1.start_order == 0
        assert p2.start_order == 1
        assert p3.start_order == 2

    async def test_stop_reverses_start_order(self, orchestrator):
        counter = {"value": 0}
        p1 = FakeProvider("first")
        p2 = FakeProvider("second")

        original_stop_p1 = p1.stop
        original_stop_p2 = p2.stop

        async def track_stop_p1():
            await original_stop_p1()
            p1.stop_order = counter["value"]
            counter["value"] += 1

        async def track_stop_p2():
            await original_stop_p2()
            p2.stop_order = counter["value"]
            counter["value"] += 1

        p1.stop = track_stop_p1
        p2.stop = track_stop_p2

        await orchestrator.start({"p1": p1, "p2": p2}, ["p1", "p2"])
        await orchestrator.stop()

        # p2 should stop first (reverse order)
        assert p2.stop_order == 0
        assert p1.stop_order == 1
        assert not orchestrator.running

    async def test_stop_all_providers(self, orchestrator):
        p1 = FakeProvider("a")
        p2 = FakeProvider("b")
        await orchestrator.start({"p1": p1, "p2": p2}, ["p1", "p2"])

        await orchestrator.stop()
        assert p1.stopped
        assert p2.stopped

    async def test_start_with_empty_providers(self, orchestrator):
        await orchestrator.start({}, [])
        assert orchestrator.running

    async def test_stop_idempotent_when_empty(self, orchestrator):
        await orchestrator.stop()  # Should not raise


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
