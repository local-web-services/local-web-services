"""Then: receiving_message_returns_body"""

from __future__ import annotations

from pytest_bdd import parsers, then

from ..constants import ScenarioContext


@then(
    parsers.parse(
        'receiving {count:d} message from "{queue_name}" will return body "{expected_body}"'
    )
)  # noqa: E501
@then(
    parsers.parse(
        'receiving {count:d} messages from "{queue_name}" will return body "{expected_body}"'
    )
)  # noqa: E501
def receiving_message_returns_body(
    ctx: ScenarioContext, count: int, queue_name: str, expected_body: str
) -> None:
    actual_messages = ctx.sqs_helper.receive(max_messages=count)
    assert len(actual_messages) == count, f"expected {count} message(s), got {len(actual_messages)}"
    actual_body = actual_messages[0]["Body"]
    assert actual_body == expected_body, f"message body = {actual_body!r}, want {expected_body!r}"
