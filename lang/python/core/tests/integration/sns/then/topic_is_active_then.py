"""Then: the topic is "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import TEST_TOPIC


@then('the topic is "ACTIVE"')
def topic_is_active_then(client):
    r = client.post("/", data={"Action": "ListTopics"})
    expected_fragment = TEST_TOPIC
    actual_text = r.text
    assert (
        expected_fragment in actual_text
    ), f"Expected topic '{expected_fragment}' to be ACTIVE but not found in: {actual_text}"
