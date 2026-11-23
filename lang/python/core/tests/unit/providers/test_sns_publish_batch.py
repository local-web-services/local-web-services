"""Tests for SNS PublishBatch operation."""

from __future__ import annotations

import pytest

from lws.providers.sns.provider import SnsProvider, TopicConfig


@pytest.fixture()
async def provider_with_topic() -> SnsProvider:
    topic_name = "batch-topic"
    provider = SnsProvider(
        topics=[
            TopicConfig(
                topic_name=topic_name,
                topic_arn=f"arn:aws:sns:us-east-1:000000000000:{topic_name}",
            )
        ]
    )
    await provider.start()
    return provider


@pytest.mark.asyncio
async def test_publish_batch_returns_one_successful_entry_per_message(
    provider_with_topic: SnsProvider,
) -> None:
    # Arrange
    provider = provider_with_topic
    expected_topic_name = "batch-topic"
    expected_entry_count = 2
    entries = [
        {"Id": "msg-1", "Message": "hello"},
        {"Id": "msg-2", "Message": "world"},
    ]

    # Act
    actual_results = await provider.publish_batch(
        topic_name=expected_topic_name, entries=entries
    )

    # Assert
    assert len(actual_results) == expected_entry_count
    actual_ids = [r["Id"] for r in actual_results]
    expected_id_1 = "msg-1"
    expected_id_2 = "msg-2"
    assert expected_id_1 in actual_ids
    assert expected_id_2 in actual_ids
    for result in actual_results:
        assert result["MessageId"] != ""
