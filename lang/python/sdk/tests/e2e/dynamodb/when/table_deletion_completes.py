"""When: a "dynamodb" "table" deletion completes"""

from __future__ import annotations

import json as _json
import urllib.request as _urllib_req

from pytest_bdd import when

from ..constants import TEST_TABLE


@when('a "dynamodb" "table" deletion completes')
def table_deletion_completes(lws_session, world):
    """Complete a table deletion.

    Validates preconditions: table must be in DELETING state (lifecycle delete dwell active).
    If the precondition holds, resets delete dwell to 0 and deletes the table immediately.
    """
    client = lws_session.client("dynamodb")
    all_tables = client.list_tables()["TableNames"]
    if TEST_TABLE not in all_tables:
        world["error"] = Exception(f"Table '{TEST_TABLE}' does not exist; cannot complete deletion")
        world["result"] = None
        return
    with _urllib_req.urlopen(f"http://127.0.0.1:{lws_session._mgmt_port}/_ldk/lifecycle") as _resp:
        lifecycle_cfg = _json.loads(_resp.read()).get("dynamodb", {})
    lifecycle_enabled = lifecycle_cfg.get("enabled", False)
    delete_dwell_ms = lifecycle_cfg.get("delete_dwell_ms", 0)
    if not lifecycle_enabled or delete_dwell_ms == 0:
        world["error"] = Exception(
            f"Table '{TEST_TABLE}' is not in DELETING state (lifecycle delete dwell not active); cannot complete deletion"  # noqa: E501
        )
        world["result"] = None
        return
    lws_session.lifecycle("dynamodb").delete_dwell_ms(0).apply()
    try:
        world["result"] = client.delete_table(TableName=TEST_TABLE)
        world["error"] = None
    except Exception as exc:
        world["result"] = None
        world["error"] = exc
