"""Then: the job is Succeeded and its output is available"""

from __future__ import annotations

from pytest_bdd import then


@then("the job is Succeeded and its output is available")
def job_is_succeeded_and_output_available(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected job to succeed but got: {actual_error}"
