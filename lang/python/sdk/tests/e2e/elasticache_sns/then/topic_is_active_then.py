"""Then: the topic is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..client import ElasticacheSnsTestClient
from ..constants import TEST_TOPIC


@then('the topic is "ACTIVE"')
def topic_is_active_then(lws_session):
    resp = ElasticacheSnsTestClient(lws_session)._sns.list_topics()
    actual_arns = [t["TopicArn"] for t in resp.get("Topics", [])]
    assert any(
        TEST_TOPIC in arn for arn in actual_arns
    ), f"Expected topic '{TEST_TOPIC}' to be ACTIVE but not found in: {actual_arns}"
