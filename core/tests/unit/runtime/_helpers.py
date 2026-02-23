from __future__ import annotations

from lws.interfaces.provider import Provider, ProviderStatus


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
