"""Tests for LDK interface definitions (P0-07 through P0-10)."""

from ldk.interfaces import (
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
        assert ProviderStatus.STOPPED.value == "stopped"

    def test_has_starting(self) -> None:
        assert ProviderStatus.STARTING.value == "starting"

    def test_has_running(self) -> None:
        assert ProviderStatus.RUNNING.value == "running"

    def test_has_error(self) -> None:
        assert ProviderStatus.ERROR.value == "error"

    def test_member_count(self) -> None:
        assert len(ProviderStatus) == 4
