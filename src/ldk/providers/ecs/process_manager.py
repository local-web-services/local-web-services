"""Process manager for ECS service containers.

Manages subprocesses that simulate ECS task containers.  Each managed process
is started via ``asyncio.create_subprocess_exec``, with stdout/stderr streamed
and prefixed by service name.  Graceful shutdown uses SIGTERM followed by
SIGKILL after a configurable grace period.
"""

from __future__ import annotations

import asyncio
import logging
import os
import signal
from dataclasses import dataclass, field

logger = logging.getLogger(__name__)


@dataclass
class ProcessConfig:
    """Configuration for a single managed process.

    Attributes:
        service_name: Human-readable name used for log prefixes.
        command: The command tokens to execute (e.g. ``["python", "app.py"]``).
        environment: Environment variables to inject into the subprocess.
        working_dir: Optional working directory for the subprocess.
        grace_period: Seconds to wait after SIGTERM before sending SIGKILL.
    """

    service_name: str
    command: list[str]
    environment: dict[str, str] = field(default_factory=dict)
    working_dir: str | None = None
    grace_period: float = 10.0


class ManagedProcess:
    """Wraps an asyncio subprocess with streaming output and graceful stop.

    The process is **not** started in ``__init__``; call :meth:`start` to
    spawn and begin streaming.
    """

    def __init__(self, config: ProcessConfig) -> None:
        self._config = config
        self._process: asyncio.subprocess.Process | None = None
        self._stream_tasks: list[asyncio.Task[None]] = []
        self._running = False

    @property
    def is_running(self) -> bool:
        """Return ``True`` if the subprocess is alive."""
        return self._running and self._process is not None and self._process.returncode is None

    @property
    def pid(self) -> int | None:
        """Return the PID of the underlying subprocess, or ``None``."""
        return self._process.pid if self._process else None

    # ------------------------------------------------------------------
    # Lifecycle
    # ------------------------------------------------------------------

    async def start(self) -> None:
        """Spawn the subprocess and start streaming stdout/stderr."""
        env = self._build_env()
        self._process = await asyncio.create_subprocess_exec(
            *self._config.command,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
            env=env,
            cwd=self._config.working_dir,
        )
        self._running = True
        self._stream_tasks = [
            asyncio.create_task(self._stream(self._process.stdout, "stdout")),
            asyncio.create_task(self._stream(self._process.stderr, "stderr")),
        ]
        logger.info(
            "[%s] started (pid=%s)",
            self._config.service_name,
            self._process.pid,
        )

    async def stop(self) -> None:
        """Gracefully stop: SIGTERM, wait grace period, then SIGKILL."""
        if self._process is None or self._process.returncode is not None:
            self._running = False
            return

        self._send_signal(signal.SIGTERM)
        try:
            await asyncio.wait_for(
                self._process.wait(),
                timeout=self._config.grace_period,
            )
        except TimeoutError:
            logger.warning(
                "[%s] did not exit in %.1fs, sending SIGKILL",
                self._config.service_name,
                self._config.grace_period,
            )
            self._process.kill()
            await self._process.wait()

        await self._cancel_streams()
        self._running = False
        logger.info("[%s] stopped", self._config.service_name)

    async def wait(self) -> int:
        """Block until the subprocess exits.  Returns the exit code."""
        if self._process is None:
            return -1
        code = await self._process.wait()
        await self._cancel_streams()
        self._running = False
        return code

    # ------------------------------------------------------------------
    # Internal helpers
    # ------------------------------------------------------------------

    def _build_env(self) -> dict[str, str]:
        """Merge ``os.environ`` with the configured environment variables."""
        env: dict[str, str] = {}
        env.update(os.environ)
        env.update(self._config.environment)
        return env

    def _send_signal(self, sig: signal.Signals) -> None:
        """Send *sig* to the subprocess, ignoring ``ProcessLookupError``."""
        if self._process is None:
            return
        try:
            self._process.send_signal(sig)
        except ProcessLookupError:
            pass

    async def _stream(
        self,
        reader: asyncio.StreamReader | None,
        label: str,
    ) -> None:
        """Read lines from *reader* and log with service-name prefix."""
        if reader is None:
            return
        name = self._config.service_name
        while True:
            line = await reader.readline()
            if not line:
                break
            text = line.decode("utf-8", errors="replace").rstrip()
            logger.info("[%s:%s] %s", name, label, text)

    async def _cancel_streams(self) -> None:
        """Cancel any active stream-reading tasks."""
        for task in self._stream_tasks:
            task.cancel()
        for task in self._stream_tasks:
            try:
                await task
            except asyncio.CancelledError:
                pass
        self._stream_tasks = []
