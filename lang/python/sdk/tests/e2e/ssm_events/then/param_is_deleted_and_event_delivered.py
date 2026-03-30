"""Then: the parameter is "DELETED" and the "DELETED" event is "DELIVERED" """

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import then

from ..constants import TEST_PARAM


@then('the parameter is "DELETED" and the "DELETED" event is "DELIVERED"')
def param_is_deleted_and_event_delivered(lws_session):
    try:
        lws_session.client("ssm").get_parameter(Name=TEST_PARAM)
        raise AssertionError(f"Expected parameter '{TEST_PARAM}' to be deleted but it still exists")
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        assert (
            error_code == "ParameterNotFound"
        ), f"Expected ParameterNotFound but got: {error_code}"
