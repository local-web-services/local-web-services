"""Constants and shared helpers."""

from __future__ import annotations

TEST_TABLE = "int-test-tbl-1"

TEST_PK = "pk"

TEST_ITEM_KEY = "int-item-key-1"

TEST_ATTR_VAL = "attr-val-1"

TEST_UPDATED_VAL = "attr-val-updated-1"


def _try_json(r) -> dict:
    try:
        return r.json()
    except Exception:
        return {"message": r.text, "status_code": r.status_code}


def _store(world: dict, r) -> None:
    if r.status_code == 200:
        world["result"] = r.json()
        world["error"] = None
    else:
        world["result"] = None
        world["error"] = _try_json(r)
