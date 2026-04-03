"""Cross-cutting provider context for AWS service factories.

Bundles optional references to cross-cutting concerns (CloudTrail, metrics,
tracing, etc.) into a single object so that adding a new concern requires one
field addition here rather than touching every ``create_*_app`` signature.
"""

from __future__ import annotations

from dataclasses import dataclass

from lws.interfaces.cloudtrail import ICloudTrail


@dataclass
class ProviderContext:
    """Shared context passed to every provider app factory."""

    cloudtrail: ICloudTrail | None = None
