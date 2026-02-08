"""Tests for ldk.runtime.synth."""

from __future__ import annotations

import time
from pathlib import Path
from unittest.mock import AsyncMock, MagicMock, patch

import pytest

from ldk.runtime.synth import SynthError, ensure_synth, is_synth_stale

# ---------------------------------------------------------------------------
# is_synth_stale
# ---------------------------------------------------------------------------


def test_is_synth_stale_no_cdk_out(tmp_path: Path) -> None:
    """When cdk.out does not exist, synth should be considered stale."""
    assert is_synth_stale(tmp_path) is True


def test_is_synth_stale_no_manifest(tmp_path: Path) -> None:
    """When cdk.out exists but manifest.json is missing, synth is stale."""
    (tmp_path / "cdk.out").mkdir()
    assert is_synth_stale(tmp_path) is True


def test_is_synth_stale_source_newer(tmp_path: Path) -> None:
    """When a source file is newer than manifest.json, synth is stale."""
    cdk_out = tmp_path / "cdk.out"
    cdk_out.mkdir()
    manifest = cdk_out / "manifest.json"
    manifest.write_text("{}")

    # Ensure the source file has a strictly newer mtime.
    time.sleep(0.05)
    src_file = tmp_path / "app.ts"
    src_file.write_text("// source")

    assert is_synth_stale(tmp_path) is True


def test_is_synth_stale_manifest_newer(tmp_path: Path) -> None:
    """When manifest.json is newer than all source files, synth is fresh."""
    src_file = tmp_path / "app.ts"
    src_file.write_text("// source")

    # Ensure the manifest has a strictly newer mtime.
    time.sleep(0.05)
    cdk_out = tmp_path / "cdk.out"
    cdk_out.mkdir()
    manifest = cdk_out / "manifest.json"
    manifest.write_text("{}")

    assert is_synth_stale(tmp_path) is False


def test_is_synth_stale_excludes_node_modules(tmp_path: Path) -> None:
    """Source files inside node_modules should be ignored for staleness."""
    cdk_out = tmp_path / "cdk.out"
    cdk_out.mkdir()
    manifest = cdk_out / "manifest.json"
    manifest.write_text("{}")

    time.sleep(0.05)
    nm = tmp_path / "node_modules" / "pkg"
    nm.mkdir(parents=True)
    (nm / "index.js").write_text("// lib")

    assert is_synth_stale(tmp_path) is False


# ---------------------------------------------------------------------------
# ensure_synth
# ---------------------------------------------------------------------------


def _make_fake_process(exit_code: int = 0, stdout: bytes = b"", stderr: bytes = b""):
    """Return a mock process suitable for ``create_subprocess_exec``."""
    proc = AsyncMock()
    proc.stdout = AsyncMock()
    proc.stderr = AsyncMock()

    # readline returns bytes line-by-line then b"" to signal EOF.
    stdout_lines = [line + b"\n" for line in stdout.split(b"\n") if line] + [b""]
    stderr_lines = [line + b"\n" for line in stderr.split(b"\n") if line] + [b""]
    proc.stdout.readline = AsyncMock(side_effect=stdout_lines)
    proc.stderr.readline = AsyncMock(side_effect=stderr_lines)

    proc.wait = AsyncMock(return_value=exit_code)
    return proc


@pytest.mark.asyncio
async def test_ensure_synth_force_always_runs(tmp_path: Path) -> None:
    """With force=True, cdk synth should always run even when not stale."""
    fake_proc = _make_fake_process(exit_code=0, stdout=b"ok")

    with (
        patch(
            "ldk.runtime.synth.asyncio.create_subprocess_exec", return_value=fake_proc
        ) as mock_exec,
        patch("ldk.runtime.synth.is_synth_stale", return_value=False),
        patch("sys.stdout") as mock_stdout,
        patch("sys.stderr") as mock_stderr,
    ):
        mock_stdout.buffer = MagicMock()
        mock_stderr.buffer = MagicMock()

        result = await ensure_synth(tmp_path, force=True)

    assert result == tmp_path / "cdk.out"
    mock_exec.assert_awaited_once()


@pytest.mark.asyncio
async def test_ensure_synth_raises_synth_error(tmp_path: Path) -> None:
    """When cdk synth exits non-zero, SynthError should be raised."""
    fake_proc = _make_fake_process(exit_code=2, stderr=b"Error: something broke")

    with (
        patch("ldk.runtime.synth.asyncio.create_subprocess_exec", return_value=fake_proc),
        patch("ldk.runtime.synth.is_synth_stale", return_value=True),
        patch("sys.stdout") as mock_stdout,
        patch("sys.stderr") as mock_stderr,
    ):
        mock_stdout.buffer = MagicMock()
        mock_stderr.buffer = MagicMock()

        with pytest.raises(SynthError, match="exit code 2") as exc_info:
            await ensure_synth(tmp_path)

    assert exc_info.value.exit_code == 2


@pytest.mark.asyncio
async def test_ensure_synth_skips_when_not_stale(tmp_path: Path) -> None:
    """When synth is not stale and force is False, subprocess should not run."""
    with (
        patch("ldk.runtime.synth.asyncio.create_subprocess_exec") as mock_exec,
        patch("ldk.runtime.synth.is_synth_stale", return_value=False),
    ):
        result = await ensure_synth(tmp_path, force=False)

    assert result == tmp_path / "cdk.out"
    mock_exec.assert_not_awaited()


@pytest.mark.asyncio
async def test_ensure_synth_runs_when_stale(tmp_path: Path) -> None:
    """When synth is stale, subprocess should be invoked."""
    fake_proc = _make_fake_process(exit_code=0, stdout=b"synthesized")

    with (
        patch(
            "ldk.runtime.synth.asyncio.create_subprocess_exec", return_value=fake_proc
        ) as mock_exec,
        patch("ldk.runtime.synth.is_synth_stale", return_value=True),
        patch("sys.stdout") as mock_stdout,
        patch("sys.stderr") as mock_stderr,
    ):
        mock_stdout.buffer = MagicMock()
        mock_stderr.buffer = MagicMock()

        result = await ensure_synth(tmp_path)

    assert result == tmp_path / "cdk.out"
    mock_exec.assert_awaited_once()
