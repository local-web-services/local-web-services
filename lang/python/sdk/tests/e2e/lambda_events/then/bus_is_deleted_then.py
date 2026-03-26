"""Then: the bus is "DELETED" and Lambda PutEvents calls targeting it will fail"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import then

from ..client import LambdaEventsTestClient
from ..constants import TEST_BUS


@then('the bus is "DELETED" and Lambda PutEvents calls targeting it will fail')
def bus_is_deleted_then(lws_session):
    try:
        LambdaEventsTestClient(lws_session)._events.describe_event_bus(Name=TEST_BUS)
        raise AssertionError(f"Expected event bus '{TEST_BUS}' to be deleted but it still exists")
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        expected_code = "ResourceNotFoundException"
        assert error_code == expected_code, f"Expected '{expected_code}' but got: {error_code}"
