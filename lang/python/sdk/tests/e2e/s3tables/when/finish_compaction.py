"""When: compaction finishes on a "s3 tables" "table" """

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_TABLE


@when('compaction finishes on a "s3 tables" "table"')
def finish_compaction(lws_session, world):
    try:
        lws_session.inject_state_unchecked(
            "s3tables",
            "table",
            world.get("table_id", TEST_TABLE),
            "active",
        )
    except RuntimeError as exc:
        world["error"] = exc
