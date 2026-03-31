"""Then: the "sns" "topic" will be "ACTIVE" """

from __future__ import annotations

from pytest_bdd import then

from ..constants import _topic_arn


@then('the "sns" "topic" will be "ACTIVE"')
def topic_is_active_then(lws_session):
    resp = lws_session.client("sns").get_topic_attributes(TopicArn=_topic_arn())
    actual_arn = resp["Attributes"].get("TopicArn", "")
    expected_arn = _topic_arn()
    assert actual_arn == expected_arn, f"Expected topic ARN '{expected_arn}' but got '{actual_arn}'"
