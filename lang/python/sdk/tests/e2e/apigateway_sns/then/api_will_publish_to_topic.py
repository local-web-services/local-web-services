"""Then: the "api gateway" "API" will publish to the "sns" "topic" when requests are received"""

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewaySnsTestClient
from ..constants import _topic_arn


@then('the "api gateway" "API" will publish to the "sns" "topic" when requests are received')
def api_will_publish_to_topic(lws_session, world):
    api_id = world.get("api_id") or ApigatewaySnsTestClient(lws_session).get_api_id()
    assert api_id is not None, "Expected API to exist"
    resp = ApigatewaySnsTestClient(lws_session).invoke_api(
        api_id, {"TopicArn": _topic_arn(), "Message": "test-message"}
    )
    expected_status = 200
    actual_status = resp["status_code"]
    assert (
        actual_status == expected_status
    ), f"Expected status {expected_status!r} but got {actual_status!r}: {resp['body']}"
