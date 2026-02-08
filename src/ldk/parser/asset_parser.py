"""Parser for CDK asset manifests.

Locates asset hashes in ``manifest.json`` and maps them to their
absolute filesystem paths within the ``cdk.out/`` directory.
"""

from __future__ import annotations

import json
import logging
from pathlib import Path

logger = logging.getLogger(__name__)


def _process_asset_manifest_artifact(
    cdk_out_path: Path, artifact: dict, assets: dict[str, Path]
) -> None:
    """Process an ``aws:cdk:asset-manifest`` artifact."""
    asset_manifest_file = artifact.get("properties", {}).get("file")
    if not asset_manifest_file:
        return
    asset_manifest_path = cdk_out_path / asset_manifest_file
    if not asset_manifest_path.exists():
        logger.warning("Asset manifest not found: %s", asset_manifest_path)
        return
    _parse_asset_manifest(cdk_out_path, asset_manifest_path, assets)


def _process_metadata_assets(cdk_out_path: Path, artifact: dict, assets: dict[str, Path]) -> None:
    """Extract inline ``aws:cdk:asset`` entries from artifact metadata."""
    for meta_entries in (artifact.get("metadata") or {}).values():
        if not isinstance(meta_entries, list):
            continue
        for entry in meta_entries:
            if entry.get("type") == "aws:cdk:asset":
                _extract_asset_entry(cdk_out_path, entry.get("data", {}), assets)


def parse_assets(cdk_out_path: Path) -> dict[str, Path]:
    """Map asset hashes to filesystem paths inside *cdk_out_path*.

    Parameters
    ----------
    cdk_out_path:
        Absolute path to the ``cdk.out`` directory.

    Returns
    -------
    dict[str, Path]
        Mapping of asset source hashes to their on-disk directory/file paths.
    """
    manifest_path = cdk_out_path / "manifest.json"
    if not manifest_path.exists():
        logger.warning("manifest.json not found at %s", manifest_path)
        return {}

    with open(manifest_path, encoding="utf-8") as fh:
        manifest = json.load(fh)

    assets: dict[str, Path] = {}
    for _artifact_id, artifact in (manifest.get("artifacts") or {}).items():
        if artifact.get("type") == "aws:cdk:asset-manifest":
            _process_asset_manifest_artifact(cdk_out_path, artifact, assets)
        _process_metadata_assets(cdk_out_path, artifact, assets)

    return assets


def _parse_asset_manifest(
    cdk_out_path: Path,
    asset_manifest_path: Path,
    assets: dict[str, Path],
) -> None:
    """Parse a dedicated asset manifest file (e.g. ``MyStack.assets.json``)."""
    with open(asset_manifest_path, encoding="utf-8") as fh:
        data = json.load(fh)

    # File assets
    for asset_hash, asset_entry in (data.get("files") or {}).items():
        source = asset_entry.get("source", {})
        source_path = source.get("path")
        if source_path:
            full_path = (cdk_out_path / source_path).resolve()
            assets[asset_hash] = full_path

    # Docker image assets
    for asset_hash, asset_entry in (data.get("dockerImages") or {}).items():
        source = asset_entry.get("source", {})
        directory = source.get("directory")
        if directory:
            full_path = (cdk_out_path / directory).resolve()
            assets[asset_hash] = full_path


def _extract_asset_entry(
    cdk_out_path: Path,
    data: dict,
    assets: dict[str, Path],
) -> None:
    """Handle a single ``aws:cdk:asset`` metadata entry."""
    asset_hash = data.get("sourceHash") or data.get("id")
    path_value = data.get("path")
    if asset_hash and path_value:
        full_path = (cdk_out_path / path_value).resolve()
        assets[asset_hash] = full_path
