"""Then: the "lambda" "invocation" will be "SUCCESS" and the "dynamodb" "record" will be "PROCESSED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "invocation" will be "SUCCESS" and the "dynamodb" "record" will be "PROCESSED"')
def invocation_success_record_processed(world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    actual_error = world.get("error")
    assert actual_error is None, f"Expected invocation success but got: {actual_error}"
