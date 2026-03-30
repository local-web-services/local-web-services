"""Then: the "API" will proxy requests to the S3 bucket"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewayS3apiTestClient


@then('the "API" will proxy requests to the S3 bucket')
def api_will_proxy_to_s3(lws_session, world):
    api_id = world.get("api_id") or ApigatewayS3apiTestClient(lws_session).get_api_id()
    assert api_id is not None, "Expected API to exist"
    resp = ApigatewayS3apiTestClient(lws_session).invoke_api_put(api_id, b"test-body")
    expected_status = 200
    actual_status = resp["status_code"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}: {resp['body']}"
