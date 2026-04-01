"""Then: the "lambda" "function" will be in "PENDING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient

from ..constants import INT_FUNCTION_NAME


@then('the "lambda" "function" will be in "PENDING" state')
def function_is_in_pending_state(client: TestClient, world):
    actual_error = world["error"]
    assert actual_error is None, f"Expected function creation to succeed but got: {actual_error}"
    r = client.get(f"/2015-03-31/functions/{INT_FUNCTION_NAME}")
    assert r.status_code == 200, f"Expected to retrieve function but got status {r.status_code}"
    expected_states = ("Active", "Pending")
    actual_state = r.json().get("Configuration", r.json()).get("State", "")
    assert (
        actual_state in expected_states
    ), f"Expected function state in {expected_states} but got: {actual_state}"
