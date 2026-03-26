"""Then: the topic is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TOPIC


@then('the topic is "ACTIVE"')
def topic_is_active_then(lws_session):
    client = lws_session.client("sns")
    resp = client.list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    expected_topic = TEST_TOPIC
    assert any(
        expected_topic in arn for arn in actual_arns
    ), f"Expected topic '{expected_topic}' to exist but not found in: {actual_arns}"
