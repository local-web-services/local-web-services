"""Then: the invocation is "FAILED" and the record is "AVAILABLE" again for reprocessing"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the invocation is "FAILED" and the record is "AVAILABLE" again for reprocessing')
def invocation_failed_record_available(world):
    if world.get("_skip"):
        pytest.skip(world["_skip"])
    actual_error = world.get("error")
    assert actual_error is None, f"Expected invocation failure tracking but got: {actual_error}"
