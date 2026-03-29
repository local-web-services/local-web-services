"""Constants and shared helpers."""

from __future__ import annotations

INT_VAULT_NAME = "int-test-vault-1"

INT_ARCHIVE_BODY = b"int-test-archive-body-1"


def _store(world: dict, r, success_codes: tuple[int, ...] = (200,)) -> None:
    if r.status_code in success_codes:
        try:
            world["result"] = r.json()
        except Exception:
            world["result"] = {}
        world["error"] = None
    else:
        try:
            world["error"] = r.json()
        except Exception:
            world["error"] = {"status_code": r.status_code}
        world["result"] = None
