"""Then: the sync execution output will contain "{expected_key}" """

from __future__ import annotations

import json

from pytest_bdd import parsers, then


@then(parsers.parse('the sync execution output will contain "{expected_key}"'))
def sync_execution_output_contains_key(world, expected_key):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected no error but got: {actual_error}"
    actual_output = json.loads(world["result"]["output"])
    assert (
        expected_key in actual_output
    ), f"Expected key {expected_key!r} in output but got keys: {list(actual_output.keys())}"
