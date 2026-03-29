"""When: a table finishes creating and becomes active"""

from __future__ import annotations

from pytest_bdd import when

from ..constants import TEST_TABLE


@when("a table finishes creating and becomes active")
def activate_table(lws_session, world):
    """Disable lifecycle dwell so the table transitions to ACTIVE immediately.
    Validates preconditions: table must exist and be in CREATING state.
    """
    import time

    client = lws_session.client("dynamodb")
    all_tables = client.list_tables()["TableNames"]
    if TEST_TABLE not in all_tables:
        world["error"] = Exception(
            f"Table '{TEST_TABLE}' does not exist; cannot transition to ACTIVE"
        )
        world["result"] = None
        return
    import json as _json
    import urllib.request as _urllib_req

    with _urllib_req.urlopen(f"http://127.0.0.1:{lws_session._mgmt_port}/_ldk/lifecycle") as _resp:
        lifecycle_cfg = _json.loads(_resp.read()).get("dynamodb", {})
    lifecycle_enabled = lifecycle_cfg.get("enabled", False)
    create_dwell_ms = lifecycle_cfg.get("create_dwell_ms", 0)
    if not lifecycle_enabled or create_dwell_ms == 0:
        world["error"] = Exception(
            f"Table '{TEST_TABLE}' is not in CREATING state (lifecycle dwell not active); cannot transition to ACTIVE"  # noqa: E501
        )
        world["result"] = None
        return
    lws_session.lifecycle("dynamodb").create_dwell_ms(0).apply()
    time.sleep(0.2)
    world["result"] = None
    world["error"] = None
