"""Then: the "sns" "topic" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import _topic_arn


@then('the "sns" "topic" will be "ACTIVE"')
def apigw_sns_topic_is_active_then(lws_session):
    resp = lws_session.client("sns").list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    expected_arn = _topic_arn()
    assert (
        expected_arn in actual_arns
    ), f"Expected topic '{expected_arn}' to be ACTIVE but not found in: {actual_arns}"
