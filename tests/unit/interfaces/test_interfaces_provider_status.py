"""Tests for LDK interface definitions (P0-07 through P0-10)."""

from lws.interfaces import (
    ProviderStatus,
)

# ---------------------------------------------------------------------------
# P0-07: Provider lifecycle
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-08: ICompute
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-09: IKeyValueStore
# ---------------------------------------------------------------------------


# ---------------------------------------------------------------------------
# P0-10: Remaining provider interfaces
# ---------------------------------------------------------------------------


class TestProviderStatus:
    """ProviderStatus enum has all expected members."""

    def test_has_stopped(self) -> None:
        expected_value = "stopped"
        assert ProviderStatus.STOPPED.value == expected_value

    def test_has_starting(self) -> None:
        expected_value = "starting"
        assert ProviderStatus.STARTING.value == expected_value

    def test_has_running(self) -> None:
        expected_value = "running"
        assert ProviderStatus.RUNNING.value == expected_value

    def test_has_error(self) -> None:
        expected_value = "error"
        assert ProviderStatus.ERROR.value == expected_value

    def test_member_count(self) -> None:
        expected_count = 4
        actual_count = len(ProviderStatus)
        assert actual_count == expected_count
