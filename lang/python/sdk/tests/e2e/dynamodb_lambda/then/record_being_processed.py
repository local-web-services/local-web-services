"""Then: the record is being processed and a Lambda invocation is "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the record is being processed and a Lambda invocation is "IN_PROGRESS"')
def record_being_processed(lws_session, world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    actual_error = world.get("error")
    assert (
        actual_error is None
    ), f"Expected stream poll and invocation to succeed but got: {actual_error}"
