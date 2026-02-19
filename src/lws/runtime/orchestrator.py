"""Provider lifecycle orchestrator.

Starts and stops providers in dependency order derived from the application
graph's topological sort.  Health-checks each provider after it starts and
performs reverse-order shutdown on stop or signal.  On shutdown, providers
that support ``flush()`` are given a chance to persist state before stopping.
"""

from __future__ import annotations

import asyncio
import logging
import os
import signal
import threading

from rich.console import Console

from lws.interfaces.provider import Provider, ProviderStartError

logger = logging.getLogger(__name__)

_console = Console(stderr=True)


class Orchestrator:
    """Manage the lifecycle of a set of providers according to an AppGraph.

    Providers are started in topological order (dependencies first) and
    stopped in reverse order.  SIGINT and SIGTERM trigger a graceful
    shutdown.  A second signal forces an immediate exit.
    """

    def __init__(self) -> None:
        self._providers: dict[str, Provider] = {}
        self._startup_order: list[str] = []
        self._running = False
        self._stop_event: asyncio.Event | None = None
        self._shutting_down = False

    # ------------------------------------------------------------------
    # Public API
    # ------------------------------------------------------------------

    async def start(
        self,
        providers: dict[str, Provider],
        startup_order: list[str],
    ) -> None:
        """Start all providers in *startup_order*.

        Args:
            providers: Map of node ID to ``Provider`` instance.
            startup_order: Node IDs in topological (dependency-first) order.
        """
        self._providers = providers
        self._startup_order = startup_order
        self._stop_event = asyncio.Event()

        self._install_signal_handlers()

        for node_id in self._startup_order:
            provider = self._providers.get(node_id)
            if provider is None:
                continue

            logger.info("Starting provider: %s", provider.name)
            try:
                await provider.start()
            except Exception as exc:
                logger.error("Failed to start %s: %s", provider.name, exc)
                await self.stop()
                raise ProviderStartError(
                    f"Provider {provider.name} failed to start: {exc}"
                ) from exc

            healthy = await provider.health_check()
            if not healthy:
                logger.warning("Provider %s started but health check failed", provider.name)

            logger.info("Provider %s started successfully", provider.name)

        self._running = True
        logger.info("All providers started")

    async def stop(self) -> None:
        """Stop all providers in reverse startup order.

        Before stopping, providers that expose a ``flush()`` coroutine are
        given a chance to persist their in-memory state to disk.
        """
        if not self._providers:
            return

        _console.print("[bold yellow]Shutting down...[/bold yellow]")
        logger.info("Shutting down providers...")

        # Flush state on providers that support it
        await self._flush_providers()

        for node_id in reversed(self._startup_order):
            provider = self._providers.get(node_id)
            if provider is None:
                continue
            logger.info("Stopping provider: %s", provider.name)
            try:
                await asyncio.wait_for(provider.stop(), timeout=30.0)
            except TimeoutError:
                logger.warning("Timed out stopping provider %s — skipping", provider.name)
            except Exception:
                logger.exception("Error stopping provider %s", provider.name)

        self._running = False
        self._providers.clear()
        self._startup_order.clear()
        logger.info("All providers stopped")

    async def _flush_providers(self) -> None:
        """Call ``flush()`` on every provider that supports it."""
        for node_id in self._startup_order:
            provider = self._providers.get(node_id)
            if provider is None:
                continue
            flush_fn = getattr(provider, "flush", None)
            if flush_fn is not None and callable(flush_fn):
                try:
                    logger.info("Flushing state for %s", provider.name)
                    await flush_fn()
                except Exception:
                    logger.exception("Error flushing provider %s", provider.name)

    async def wait_for_shutdown(self) -> None:
        """Block until a shutdown signal is received."""
        if self._stop_event is None:
            return
        await self._stop_event.wait()

    def request_shutdown(self) -> None:
        """Trigger graceful shutdown (same as SIGTERM)."""
        if not self._shutting_down:
            self._shutting_down = True
            if self._stop_event is not None:
                self._stop_event.set()

    @property
    def providers(self) -> dict[str, Provider]:
        """Return the providers dict."""
        return self._providers

    @property
    def running(self) -> bool:
        """Return True if all providers have been started and not yet stopped."""
        return self._running

    # ------------------------------------------------------------------
    # Signal handling
    # ------------------------------------------------------------------

    def _install_signal_handlers(self) -> None:
        if threading.current_thread() is not threading.main_thread():
            return
        loop = asyncio.get_running_loop()
        for sig in (signal.SIGINT, signal.SIGTERM):
            loop.add_signal_handler(sig, self._handle_signal, sig)

    def _handle_signal(self, sig: signal.Signals) -> None:
        if self._shutting_down:
            # Second signal: force immediate exit
            _console.print("[bold red]Forced exit.[/bold red]")
            os._exit(1)

        logger.info("Received %s, initiating shutdown...", sig.name)
        self._shutting_down = True
        if self._stop_event is not None:
            self._stop_event.set()
