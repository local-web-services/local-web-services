"""Unit tests for the Orchestrator provider lifecycle manager."""

from __future__ import annotations

import pytest

from ._helpers import FakeProvider


@pytest.fixture
def orchestrator():
    from lws.runtime.orchestrator import Orchestrator

    return Orchestrator()


class TestOrchestratorStartStop:
    """Tests for start and stop lifecycle."""

    async def test_start_single_provider(self, orchestrator):
        p = FakeProvider("test-provider")
        await orchestrator.start({"p1": p}, ["p1"])
        assert p.started
        assert orchestrator.running

    async def test_start_multiple_providers_in_order(self, orchestrator):
        # Arrange
        expected_p1_order = 0
        expected_p2_order = 1
        expected_p3_order = 2
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

        # Act
        await orchestrator.start(
            {"p1": p1, "p2": p2, "p3": p3},
            ["p1", "p2", "p3"],
        )

        # Assert
        assert p1.start_order == expected_p1_order
        assert p2.start_order == expected_p2_order
        assert p3.start_order == expected_p3_order

    async def test_stop_reverses_start_order(self, orchestrator):
        # Arrange
        expected_p2_stop_order = 0
        expected_p1_stop_order = 1
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

        # Act
        await orchestrator.start({"p1": p1, "p2": p2}, ["p1", "p2"])
        await orchestrator.stop()

        # Assert -- p2 should stop first (reverse order)
        assert p2.stop_order == expected_p2_stop_order
        assert p1.stop_order == expected_p1_stop_order
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
