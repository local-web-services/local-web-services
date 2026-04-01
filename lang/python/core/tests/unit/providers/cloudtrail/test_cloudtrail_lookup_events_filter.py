"""Tests for CloudTrailProvider.lookup_events filtering and pagination."""

from __future__ import annotations

from lws.providers.cloudtrail.provider import CloudTrailProvider


def _make_event(name: str, source: str = "sqs.amazonaws.com", username: str = "dev") -> dict:
    return {
        "eventName": name,
        "eventSource": source,
        "eventTime": "2026-04-01T10:00:00Z",
        "eventID": f"id-{name}",
        "userIdentity": {"userName": username},
        "readOnly": False,
        "resources": [],
    }


class TestCloudTrailLookupEventsFilter:
    """LookupEvents: attribute filters, time range, and pagination."""

    async def test_filter_by_event_name(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.record_event(_make_event("CreateQueue"))
        provider.record_event(_make_event("DeleteQueue"))

        # Act
        actual = await provider.lookup_events(
            lookup_attributes=[{"AttributeKey": "EventName", "AttributeValue": "CreateQueue"}]
        )

        # Assert
        expected_count = 1
        assert len(actual["Events"]) == expected_count
        assert actual["Events"][0]["EventName"] == "CreateQueue"

    async def test_filter_by_event_source(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.record_event(_make_event("CreateQueue", source="sqs.amazonaws.com"))
        provider.record_event(_make_event("CreateTable", source="dynamodb.amazonaws.com"))

        # Act
        actual = await provider.lookup_events(
            lookup_attributes=[
                {"AttributeKey": "EventSource", "AttributeValue": "sqs.amazonaws.com"}
            ]
        )

        # Assert
        expected_count = 1
        assert len(actual["Events"]) == expected_count
        assert actual["Events"][0]["EventSource"] == "sqs.amazonaws.com"

    async def test_filter_by_username(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        provider.record_event(_make_event("CreateQueue", username="alice"))
        provider.record_event(_make_event("CreateQueue", username="bob"))

        # Act
        actual = await provider.lookup_events(
            lookup_attributes=[{"AttributeKey": "Username", "AttributeValue": "alice"}]
        )

        # Assert
        expected_count = 1
        assert len(actual["Events"]) == expected_count
        assert actual["Events"][0]["Username"] == "alice"

    async def test_no_filter_returns_all(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        for i in range(3):
            provider.record_event(_make_event(f"Op{i}"))

        # Act
        actual = await provider.lookup_events()

        # Assert
        expected_count = 3
        assert len(actual["Events"]) == expected_count

    async def test_pagination_returns_next_token(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        for i in range(55):
            provider.record_event(_make_event(f"Op{i}"))

        # Act
        actual = await provider.lookup_events(max_results=50)

        # Assert
        expected_page_size = 50
        assert len(actual["Events"]) == expected_page_size
        assert "NextToken" in actual

    async def test_pagination_next_page(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        for i in range(55):
            provider.record_event(_make_event(f"Op{i}"))
        first = await provider.lookup_events(max_results=50)
        expected_remaining = 5

        # Act
        actual = await provider.lookup_events(max_results=50, next_token=first["NextToken"])

        # Assert
        assert len(actual["Events"]) == expected_remaining
        assert "NextToken" not in actual

    async def test_time_range_filter(self) -> None:
        # Arrange
        provider = CloudTrailProvider()
        early = dict(_make_event("EarlyOp"))
        early["eventTime"] = "2026-01-01T00:00:00Z"
        late = dict(_make_event("LateOp"))
        late["eventTime"] = "2026-04-01T10:00:00Z"
        provider.record_event(early)
        provider.record_event(late)

        # Act
        actual = await provider.lookup_events(
            start_time="2026-03-01T00:00:00Z",
            end_time="2026-05-01T00:00:00Z",
        )

        # Assert
        expected_count = 1
        assert len(actual["Events"]) == expected_count
        assert actual["Events"][0]["EventName"] == "LateOp"
