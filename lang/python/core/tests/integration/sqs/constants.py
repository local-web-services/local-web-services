"""Constants and shared helpers."""

from __future__ import annotations

TEST_QUEUE = "int-test-q-1"

TEST_DLQ = "int-test-dlq-1"

TEST_MESSAGE = "int-test-message-body-1"

QUEUE_URL = f"http://testserver/000000000000/{TEST_QUEUE}"

DLQ_URL = f"http://testserver/000000000000/{TEST_DLQ}"


def _extract_xml_tag(text: str, tag: str) -> str:
    open_tag = f"<{tag}>"
    close_tag = f"</{tag}>"
    start = text.index(open_tag) + len(open_tag)
    end = text.index(close_tag)
    return text[start:end]
