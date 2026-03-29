"""Constants and shared helpers."""

from __future__ import annotations

INT_DOMAIN = "int-elasticsearch-domain-1"

INT_INDEX = "int-elasticsearch-index-1"

INT_TAG_KEY = "int-elasticsearch-tag-key-1"

INT_TAG_VALUE = "int-elasticsearch-tag-value-1"

_ES_TARGET = "ElasticsearchService_20150101"


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = r.json()
