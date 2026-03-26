"""Then: the topic is deleted"""

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TOPIC


@then("the topic is deleted")
def topic_is_deleted_then(client):
    r = client.post("/", data={"Action": "ListTopics"})
    expected_absent = TEST_TOPIC
    actual_text = r.text
    assert (
        expected_absent not in actual_text
    ), f"Expected topic '{expected_absent}' to be deleted but found in: {actual_text}"
