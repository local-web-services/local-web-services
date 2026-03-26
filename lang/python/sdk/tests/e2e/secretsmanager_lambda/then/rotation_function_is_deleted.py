"""Then: the function is "DELETED" and rotation will fail"""

from __future__ import annotations

from pytest_bdd import then

from ..client import SecretsmanagerLambdaTestClient


@then('the function is "DELETED" and rotation will fail')
def rotation_function_is_deleted(lws_session):
    expected_exists = False
    actual_exists = SecretsmanagerLambdaTestClient(lws_session).get_function_exists()
    assert (
        actual_exists == expected_exists
    ), "Expected rotation function to be deleted but it still exists"
