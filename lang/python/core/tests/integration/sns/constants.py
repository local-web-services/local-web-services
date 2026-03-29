"""Constants and shared helpers."""

from __future__ import annotations

TEST_TOPIC = "int-test-topic-1"

TEST_TOPIC_ARN = f"arn:aws:sns:us-east-1:000000000000:{TEST_TOPIC}"

TEST_EMAIL_ENDPOINT = "int-test@example.invalid"

TEST_MESSAGE = "int-test-sns-message-1"

TEST_SUB_ENDPOINT = "arn:aws:sqs:us-east-1:000000000000:int-test-sub-q"


def _extract_xml_tag(text: str, tag: str) -> str:
    open_tag = f"<{tag}>"
    close_tag = f"</{tag}>"
    start = text.index(open_tag) + len(open_tag)
    end = text.index(close_tag)
    return text[start:end]
