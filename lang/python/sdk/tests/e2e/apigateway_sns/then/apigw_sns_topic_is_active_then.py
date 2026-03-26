"""Then: the topic is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import ApigatewaySnsTestClient
from ..constants import _topic_arn


@then('the topic is "ACTIVE"')
def apigw_sns_topic_is_active_then(lws_session):
    resp = ApigatewaySnsTestClient(lws_session)._sns.list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    expected_arn = _topic_arn()
    assert (
        expected_arn in actual_arns
    ), f"Expected topic '{expected_arn}' to be ACTIVE but not found in: {actual_arns}"
