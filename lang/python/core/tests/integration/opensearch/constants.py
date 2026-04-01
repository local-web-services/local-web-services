"""Constants and shared helpers."""

from __future__ import annotations

INT_DOMAIN = "int-opensearch-domain-1"

INT_DOMAIN2 = "int-opensearch-domain-2"

INT_TAG_KEY = "int-opensearch-tag-key-1"

INT_TAG_VALUE = "int-opensearch-tag-value-1"

_OS_TARGET = "OpenSearchService_20210101"


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
