"""Then: the parameter is "DELETED" and will cause a ParameterNotFound error when read"""

from __future__ import annotations

from botocore.exceptions import ClientError
from pytest_bdd import then

from ..client import LambdaSsmTestClient
from ..constants import TEST_PARAM


@then('the parameter is "DELETED" and will cause a ParameterNotFound error when read')
def param_is_deleted_then(lws_session):
    try:
        LambdaSsmTestClient(lws_session)._ssm.get_parameter(Name=TEST_PARAM)
        raise AssertionError(f"Expected parameter '{TEST_PARAM}' to be deleted but it still exists")
    except ClientError as exc:
        error_code = exc.response["Error"]["Code"]
        expected_code = "ParameterNotFound"
        assert error_code == expected_code, f"Expected '{expected_code}' but got: {error_code}"
