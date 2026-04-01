"""Then: the mapping will be in "CREATING" state and linked to a "lambda" "function" """

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the mapping will be in "CREATING" state and linked to a "lambda" "function"')
def mapping_is_in_creating_state(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected event source mapping creation to succeed but got: {actual_error}"
    r = client.get("/2015-03-31/event-source-mappings")
    mappings = r.json().get("EventSourceMappings", [])
    assert mappings, "Expected at least one event source mapping but found none"
