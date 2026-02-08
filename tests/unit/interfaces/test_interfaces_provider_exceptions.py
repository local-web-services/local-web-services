"""Tests for LDK interface definitions (P0-07 through P0-10)."""

import pytest

from ldk.interfaces import (
    ProviderError,
    ProviderStartError,
    ProviderStopError,
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


class TestProviderExceptions:
    """Provider exception hierarchy is correct."""

    def test_provider_error_is_exception(self) -> None:
        assert issubclass(ProviderError, Exception)

    def test_start_error_inherits_provider_error(self) -> None:
        assert issubclass(ProviderStartError, ProviderError)

    def test_stop_error_inherits_provider_error(self) -> None:
        assert issubclass(ProviderStopError, ProviderError)

    def test_raise_start_error(self) -> None:
        with pytest.raises(ProviderStartError):
            raise ProviderStartError("boom")

    def test_raise_stop_error(self) -> None:
        with pytest.raises(ProviderStopError):
            raise ProviderStopError("boom")
