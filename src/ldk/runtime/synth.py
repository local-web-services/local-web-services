"""CDK Synth Runner.

Manages running ``cdk synth`` for a CDK project, with staleness detection so
synthesis is only repeated when source files have changed.
"""

from __future__ import annotations

import asyncio
import sys
from pathlib import Path

# File extensions considered as CDK source files.
_SOURCE_EXTENSIONS: frozenset[str] = frozenset({".ts", ".js", ".py", ".java"})

# Directory names excluded when scanning for source files.
_EXCLUDED_DIRS: frozenset[str] = frozenset({"node_modules", ".git", "cdk.out"})


class SynthError(Exception):
    """Raised when cdk synth fails."""

    def __init__(self, message: str, exit_code: int) -> None:
        super().__init__(message)
        self.exit_code = exit_code


def _iter_source_files(project_dir: Path):
    """Yield all source files in *project_dir*, skipping excluded directories."""
    for child in project_dir.iterdir():
        if child.is_dir():
            if child.name in _EXCLUDED_DIRS:
                continue
            yield from _iter_source_files(child)
        elif child.suffix in _SOURCE_EXTENSIONS:
            yield child


def is_synth_stale(project_dir: Path) -> bool:
    """Return ``True`` if ``cdk synth`` needs to be re-run.

    Staleness is determined by comparing the mtime of
    ``cdk.out/manifest.json`` against all CDK source files (``.ts``,
    ``.js``, ``.py``, ``.java``) found in *project_dir* (excluding
    ``node_modules``, ``.git``, and ``cdk.out`` directories).

    Args:
        project_dir: Root of the CDK project.

    Returns:
        ``True`` when synthesis output is missing or outdated.
    """
    manifest = project_dir / "cdk.out" / "manifest.json"
    if not manifest.exists():
        return True

    manifest_mtime = manifest.stat().st_mtime

    for source_file in _iter_source_files(project_dir):
        if source_file.stat().st_mtime > manifest_mtime:
            return True

    return False


async def ensure_synth(project_dir: Path, force: bool = False) -> Path:
    """Ensure that ``cdk synth`` output is up-to-date and return its path.

    When *force* is ``True`` synthesis is always executed.  Otherwise the
    function checks :func:`is_synth_stale` and skips the run if the
    existing output is still fresh.

    Stdout and stderr from the ``cdk synth`` subprocess are streamed to
    the terminal line-by-line in real time.

    Args:
        project_dir: Root of the CDK project (must contain a ``cdk.json``
            or equivalent CDK configuration).
        force: Re-run synthesis regardless of staleness.

    Returns:
        The :class:`~pathlib.Path` to the ``cdk.out`` directory.

    Raises:
        SynthError: If the ``cdk synth`` process exits with a non-zero code.
    """
    cdk_out = project_dir / "cdk.out"

    if not force and not is_synth_stale(project_dir):
        return cdk_out

    proc = await asyncio.create_subprocess_exec(
        "cdk",
        "synth",
        cwd=str(project_dir),
        stdout=asyncio.subprocess.PIPE,
        stderr=asyncio.subprocess.PIPE,
    )

    async def _stream(stream: asyncio.StreamReader, dest) -> None:
        while True:
            line = await stream.readline()
            if not line:
                break
            dest.buffer.write(line)
            dest.buffer.flush()

    assert proc.stdout is not None
    assert proc.stderr is not None

    await asyncio.gather(
        _stream(proc.stdout, sys.stdout),
        _stream(proc.stderr, sys.stderr),
    )

    exit_code = await proc.wait()

    if exit_code != 0:
        raise SynthError(
            f"cdk synth failed with exit code {exit_code}",
            exit_code=exit_code,
        )

    return cdk_out
