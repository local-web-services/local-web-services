"""CDK change detection and incremental apply.

Watches CDK source files for modifications and, on change, re-runs
``cdk synth`` to produce a fresh cloud assembly.  The new assembly is
diffed against the currently loaded state so that only changed resources
are restarted.
"""

from __future__ import annotations

import asyncio
import json
import time
from dataclasses import dataclass
from pathlib import Path

from lws.logging.logger import get_logger

_logger = get_logger("ldk.change_detector")


@dataclass
class Change:
    """Describes a single resource-level change in the cloud assembly.

    Attributes:
        resource_id: Logical ID of the changed resource.
        change_type: One of ``"ADD"``, ``"REMOVE"``, ``"UPDATE"``.
        old_config: Previous resource configuration (``None`` for ADDs).
        new_config: New resource configuration (``None`` for REMOVEs).
    """

    resource_id: str
    change_type: str  # ADD, REMOVE, UPDATE
    old_config: dict | None = None
    new_config: dict | None = None


class CdkChangeDetector:
    """Detect CDK source file changes and incrementally apply them.

    Monitors the project directory for CDK source file modifications and
    debounces rapid successive changes (500ms window).  On change it
    re-runs ``cdk synth``, diffs the resulting cloud assembly against the
    cached state, and returns a list of ``Change`` objects.

    Args:
        project_dir: Root of the CDK project.
        cdk_out_dir: Name of the CDK output directory (default ``"cdk.out"``).
        debounce_seconds: Debounce window for rapid changes.
    """

    def __init__(
        self,
        project_dir: Path,
        cdk_out_dir: str = "cdk.out",
        debounce_seconds: float = 0.5,
    ) -> None:
        self._project_dir = project_dir
        self._cdk_out = project_dir / cdk_out_dir
        self._debounce_seconds = debounce_seconds
        self._current_state: dict[str, dict] = {}
        self._last_synth_time: float = 0.0

    async def load_current_state(self) -> None:
        """Load the current cloud assembly state into memory for diffing."""
        self._current_state = self._read_template_resources()

    def detect_changes(self) -> list[Change]:
        """Compare the current cloud assembly against the cached state.

        Returns:
            A list of ``Change`` objects describing added, removed, or
            updated resources.
        """
        new_state = self._read_template_resources()
        changes: list[Change] = []

        all_ids = set(self._current_state.keys()) | set(new_state.keys())
        for resource_id in sorted(all_ids):
            old = self._current_state.get(resource_id)
            new = new_state.get(resource_id)

            if old is None and new is not None:
                changes.append(Change(resource_id=resource_id, change_type="ADD", new_config=new))
            elif old is not None and new is None:
                changes.append(
                    Change(resource_id=resource_id, change_type="REMOVE", old_config=old)
                )
            elif old != new:
                changes.append(
                    Change(
                        resource_id=resource_id,
                        change_type="UPDATE",
                        old_config=old,
                        new_config=new,
                    )
                )

        return changes

    async def apply_changes(self, changes: list[Change]) -> None:
        """Apply detected changes by updating the cached state.

        In a full implementation this would restart affected providers.
        For now it updates the internal state cache and logs the changes.

        Args:
            changes: List of changes to apply.
        """
        for change in changes:
            _logger.info(
                "%s resource: %s",
                change.change_type,
                change.resource_id,
            )
            if change.change_type == "REMOVE":
                self._current_state.pop(change.resource_id, None)
            else:
                if change.new_config is not None:
                    self._current_state[change.resource_id] = change.new_config

    async def run_synth(self) -> bool:
        """Run ``cdk synth`` with debounce protection.

        Returns:
            ``True`` if synth succeeded, ``False`` on failure.
        """
        now = time.monotonic()
        if now - self._last_synth_time < self._debounce_seconds:
            _logger.debug("Debouncing synth, skipping")
            return True

        _logger.info("Running cdk synth...")
        try:
            proc = await asyncio.create_subprocess_exec(
                "cdk",
                "synth",
                cwd=str(self._project_dir),
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE,
            )
            _, stderr = await proc.communicate()
            self._last_synth_time = time.monotonic()

            if proc.returncode != 0:
                _logger.error("cdk synth failed: %s", stderr.decode().strip())
                return False

            _logger.info("cdk synth completed successfully")
            return True
        except FileNotFoundError:
            _logger.error("cdk command not found. Is AWS CDK CLI installed?")
            return False
        except Exception as exc:
            _logger.error("cdk synth error: %s", exc)
            return False

    def _read_template_resources(self) -> dict[str, dict]:
        """Read resource definitions from the cloud assembly template.

        Returns:
            A mapping of logical resource ID to resource configuration.
        """
        resources: dict[str, dict] = {}
        template_dir = self._cdk_out
        if not template_dir.exists():
            return resources

        for template_file in template_dir.glob("*.template.json"):
            try:
                data = json.loads(template_file.read_text())
                for rid, rconfig in data.get("Resources", {}).items():
                    resources[rid] = rconfig
            except (json.JSONDecodeError, OSError) as exc:
                _logger.warning("Failed to read %s: %s", template_file, exc)

        return resources
