"""Then: a "sns" "topic" is deleted"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TOPIC


@then('a "sns" "topic" is deleted')
def topic_is_deleted_then(lws_session):
    client = lws_session.client("sns")
    resp = client.list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    assert not any(
        TEST_TOPIC in arn for arn in actual_arns
    ), f"Expected topic '{TEST_TOPIC}' to be deleted but found in: {actual_arns}"
