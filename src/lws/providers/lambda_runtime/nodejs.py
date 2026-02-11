"""Node.js Lambda runtime provider extending SubprocessCompute."""

from __future__ import annotations

import shutil
from pathlib import Path

from lws.interfaces import (
    ProviderStartError,
    ProviderStatus,
)
from lws.providers.lambda_runtime.compute_base import SubprocessCompute

_INVOKER_JS = Path(__file__).parent / "invoker.js"


class NodeJsCompute(SubprocessCompute):
    """SubprocessCompute implementation that runs Lambda handlers via Node.js subprocess.

    Each invocation spawns ``node invoker.js``, passing the event payload over
    stdin and reading the result from stdout.
    """

    # -- Provider lifecycle ---------------------------------------------------

    async def start(self) -> None:
        """Verify Node.js is available and mark provider as RUNNING."""
        node_path = shutil.which("node")
        if node_path is None:
            self._status = ProviderStatus.ERROR
            raise ProviderStartError("Node.js runtime not found. Ensure 'node' is on the PATH.")
        self._status = ProviderStatus.RUNNING

    # -- Internal helpers -----------------------------------------------------

    async def _run_subprocess(self, env: dict[str, str], event_json: str) -> str:
        """Spawn ``node invoker.js`` and return its stdout."""
        return await self._exec_and_communicate(
            "node", str(_INVOKER_JS), env=env, event_json=event_json
        )
