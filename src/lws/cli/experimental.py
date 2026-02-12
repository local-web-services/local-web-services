"""Experimental service and command registry.

Central registry that tracks which services and commands are experimental.
Update this module when promoting a service to stable.
"""

from __future__ import annotations

import sys

# Services where every command is experimental.
EXPERIMENTAL_SERVICES: set[str] = {
    "docdb",
    "elasticache",
    "es",
    "glacier",
    "memorydb",
    "neptune",
    "opensearch",
    "rds",
    "s3tables",
}

# Individual commands that are experimental (service, command-name).
# Use this when only specific commands within a stable service are experimental.
EXPERIMENTAL_COMMANDS: set[tuple[str, str]] = set()


def is_experimental_service(service: str) -> bool:
    """Return True if the entire service is experimental."""
    return service in EXPERIMENTAL_SERVICES


def is_experimental_command(service: str, command: str) -> bool:
    """Return True if the command is experimental (directly or via its parent service)."""
    return (service, command) in EXPERIMENTAL_COMMANDS or service in EXPERIMENTAL_SERVICES


def warn_if_experimental(service: str, command: str | None = None) -> None:
    """Print a warning to stderr if the service or command is experimental."""
    if command and (service, command) in EXPERIMENTAL_COMMANDS:
        print(f"Warning: '{service} {command}' is experimental and may change.", file=sys.stderr)
    elif service in EXPERIMENTAL_SERVICES:
        print(f"Warning: '{service}' is experimental and may change.", file=sys.stderr)
