"""Then: the parameter "EXISTS" and the "CREATED" event is "DELIVERED" """

from __future__ import annotations

from pytest_bdd import then

from ..client import SsmEventsTestClient
from ..constants import TEST_PARAM, TEST_VALUE


@then('the parameter "EXISTS" and the "CREATED" event is "DELIVERED"')
def param_exists_and_created_event_delivered(lws_session):
    resp = SsmEventsTestClient(lws_session)._ssm.get_parameter(Name=TEST_PARAM)
    actual_value = resp["Parameter"]["Value"]
    assert (
        actual_value == TEST_VALUE
    ), f"Expected parameter value '{TEST_VALUE}' but got: {actual_value}"
