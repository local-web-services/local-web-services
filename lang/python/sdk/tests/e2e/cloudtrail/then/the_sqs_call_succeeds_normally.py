"""Then: the SQS call succeeds normally"""

from __future__ import annotations

from pytest_bdd import then


@then("the SQS call succeeds normally")
def the_sqs_call_succeeds_normally(world):
    actual_error = world.get("error")
    assert actual_error is None, f"Expected SQS call to succeed but got error: {actual_error}"
