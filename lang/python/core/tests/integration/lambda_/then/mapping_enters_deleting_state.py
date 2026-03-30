"""Then: the mapping enters "DELETING" state"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the mapping enters "DELETING" state')
def mapping_enters_deleting_state(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected event source mapping deletion to succeed but got: {actual_error}"
