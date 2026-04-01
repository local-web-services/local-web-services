"""Then: the flush succeeds"""

from __future__ import annotations

from pytest_bdd import then


@then("the flush succeeds")
def the_flush_succeeds(world):
    actual_error = world.get("error")
    flush_result = world.get("flush_result")
    if flush_result is not None and hasattr(flush_result, "status_code"):
        assert flush_result.status_code in (
            200,
            204,
        ), f"Expected flush to succeed (200/204) but got status {flush_result.status_code}"
    else:
        assert actual_error is None, f"Expected flush to succeed but got error: {actual_error}"
