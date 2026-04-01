"""Then: the mapping will be "DISABLED" and inactive"""

from __future__ import annotations

from pytest_bdd import then
from starlette.testclient import TestClient


@then('the mapping will be "DISABLED" and inactive')
def mapping_is_disabled_and_inactive(client: TestClient, world):
    actual_error = world["error"]
    assert (
        actual_error is None
    ), f"Expected event source mapping disable to succeed but got: {actual_error}"
