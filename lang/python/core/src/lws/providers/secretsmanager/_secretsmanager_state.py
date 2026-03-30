"""Secrets Manager in-memory state classes."""

from __future__ import annotations

import time
import uuid
from typing import Any

_ACCOUNT_ID = "000000000000"
_REGION = "us-east-1"


class _SecretVersion:
    """A single version of a secret."""

    def __init__(
        self,
        version_id: str,
        secret_string: str | None = None,
        secret_binary: str | None = None,
        stages: list[str] | None = None,
    ) -> None:
        self.version_id = version_id
        self.secret_string = secret_string
        self.secret_binary = secret_binary
        self.stages = stages or ["AWSCURRENT"]
        self.created_date: float = time.time()


class _Secret:
    """Represents a Secrets Manager secret."""

    def __init__(
        self,
        name: str,
        description: str = "",
        tags: dict[str, str] | None = None,
    ) -> None:
        self.name = name
        self.arn = f"arn:aws:secretsmanager:{_REGION}:{_ACCOUNT_ID}:secret:{name}"
        self.description = description
        self.tags: dict[str, str] = tags or {}
        self.versions: dict[str, _SecretVersion] = {}
        self.current_version_id: str | None = None
        self.deleted_date: float | None = None
        self.rotation_lambda_arn: str | None = None
        self.created_date: float = time.time()
        self.last_changed_date: float = time.time()


class _SecretsState:
    """In-memory store for Secrets Manager secrets."""

    def __init__(self) -> None:
        self._secrets: dict[str, _Secret] = {}

    @property
    def secrets(self) -> dict[str, _Secret]:
        """Return the secrets store."""
        return self._secrets

    def reset(self) -> None:
        """Clear all secrets from the store."""
        self._secrets.clear()


def _find_secret(state: _SecretsState, secret_id: str) -> _Secret | None:
    """Find a secret by name or ARN."""
    if secret_id in state.secrets:
        return state.secrets[secret_id]
    for s in state.secrets.values():
        if s.arn == secret_id:
            return s
    return None


def _resolve_version(
    secret: _Secret,
    version_id: str | None,
    version_stage: str,
) -> _SecretVersion | None:
    """Resolve a secret version by ID or stage."""
    if version_id:
        return secret.versions.get(version_id)
    for v in secret.versions.values():
        if version_stage in v.stages:
            return v
    return None


def _format_secret_description(secret: _Secret) -> dict[str, Any]:
    """Format a secret for DescribeSecret / ListSecrets response."""
    result: dict[str, Any] = {
        "ARN": secret.arn,
        "Name": secret.name,
        "Description": secret.description,
        "CreatedDate": secret.created_date,
        "LastChangedDate": secret.last_changed_date,
    }
    if secret.tags:
        result["Tags"] = [{"Key": k, "Value": v} for k, v in secret.tags.items()]
    if secret.deleted_date is not None:
        result["DeletedDate"] = secret.deleted_date
    # Version IDs to stages mapping
    if secret.versions:
        result["VersionIdsToStages"] = {v.version_id: v.stages for v in secret.versions.values()}
    return result


def _demote_current_to_previous(secret: _Secret) -> None:
    """Move the AWSCURRENT stage from the current version to AWSPREVIOUS."""
    if secret.current_version_id and secret.current_version_id in secret.versions:
        old = secret.versions[secret.current_version_id]
        if "AWSCURRENT" in old.stages:
            old.stages.remove("AWSCURRENT")
        if "AWSPREVIOUS" not in old.stages:
            old.stages.append("AWSPREVIOUS")


def _rotate_secret_version(
    secret: _Secret,
    secret_string: str | None,
    secret_binary: str | None,
) -> str:
    """Rotate the AWSCURRENT version and create a new one. Returns the new version_id."""
    _demote_current_to_previous(secret)

    version_id = str(uuid.uuid4())
    version = _SecretVersion(
        version_id=version_id,
        secret_string=secret_string,
        secret_binary=secret_binary,
        stages=["AWSCURRENT"],
    )
    secret.versions[version_id] = version
    secret.current_version_id = version_id
    return version_id
