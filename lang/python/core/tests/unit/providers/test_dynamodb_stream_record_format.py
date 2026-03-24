"""Tests for the DynamoDB stream record format produced on table mutations."""

from __future__ import annotations

from lws.providers.dynamodb.streams import (
    EventName,
    StreamViewType,
    build_stream_record,
)


class TestDynamodbStreamRecordFormat:
    """Test that stream records produced on mutations match the Lambda event format."""

    def test_insert_record_contains_new_image(self) -> None:
        # Arrange
        expected_event_name = "INSERT"
        expected_new_image = {"id": {"S": "item-1"}, "val": {"S": "hello"}}

        # Act
        actual_record = build_stream_record(
            event_name=EventName.INSERT,
            table_name="test-table",
            keys={"id": {"S": "item-1"}},
            new_image=expected_new_image,
            old_image=None,
            view_type=StreamViewType.NEW_AND_OLD_IMAGES,
            key_attributes=["id"],
        )

        # Assert
        actual_event_record = actual_record.to_dynamodb_event_record()
        actual_event_name = actual_event_record["eventName"]
        assert (
            actual_event_name == expected_event_name
        ), f"Expected eventName '{expected_event_name}' but got '{actual_event_name}'"
        actual_new_image = actual_event_record["dynamodb"].get("NewImage")
        assert (
            actual_new_image == expected_new_image
        ), f"Expected NewImage '{expected_new_image}' but got '{actual_new_image}'"

    def test_remove_record_contains_old_image(self) -> None:
        # Arrange
        expected_event_name = "REMOVE"
        expected_old_image = {"id": {"S": "item-2"}, "val": {"S": "world"}}

        # Act
        actual_record = build_stream_record(
            event_name=EventName.REMOVE,
            table_name="test-table",
            keys={"id": {"S": "item-2"}},
            new_image=None,
            old_image=expected_old_image,
            view_type=StreamViewType.NEW_AND_OLD_IMAGES,
            key_attributes=["id"],
        )

        # Assert
        actual_event_record = actual_record.to_dynamodb_event_record()
        actual_event_name = actual_event_record["eventName"]
        assert (
            actual_event_name == expected_event_name
        ), f"Expected eventName '{expected_event_name}' but got '{actual_event_name}'"
        actual_old_image = actual_event_record["dynamodb"].get("OldImage")
        assert (
            actual_old_image == expected_old_image
        ), f"Expected OldImage '{expected_old_image}' but got '{actual_old_image}'"

    def test_modify_record_contains_both_images(self) -> None:
        # Arrange
        expected_event_name = "MODIFY"
        expected_new_image = {"id": {"S": "item-3"}, "val": {"S": "updated"}}
        expected_old_image = {"id": {"S": "item-3"}, "val": {"S": "original"}}

        # Act
        actual_record = build_stream_record(
            event_name=EventName.MODIFY,
            table_name="test-table",
            keys={"id": {"S": "item-3"}},
            new_image=expected_new_image,
            old_image=expected_old_image,
            view_type=StreamViewType.NEW_AND_OLD_IMAGES,
            key_attributes=["id"],
        )

        # Assert
        actual_event_record = actual_record.to_dynamodb_event_record()
        actual_event_name = actual_event_record["eventName"]
        assert (
            actual_event_name == expected_event_name
        ), f"Expected eventName '{expected_event_name}' but got '{actual_event_name}'"
        actual_new_image = actual_event_record["dynamodb"].get("NewImage")
        actual_old_image = actual_event_record["dynamodb"].get("OldImage")
        assert (
            actual_new_image == expected_new_image
        ), f"Expected NewImage '{expected_new_image}' but got '{actual_new_image}'"
        assert (
            actual_old_image == expected_old_image
        ), f"Expected OldImage '{expected_old_image}' but got '{actual_old_image}'"

    def test_record_event_source_is_aws_dynamodb(self) -> None:
        # Arrange
        expected_event_source = "aws:dynamodb"

        # Act
        actual_record = build_stream_record(
            event_name=EventName.INSERT,
            table_name="test-table",
            keys={"id": {"S": "item-4"}},
            new_image={"id": {"S": "item-4"}},
            old_image=None,
            view_type=StreamViewType.NEW_AND_OLD_IMAGES,
            key_attributes=["id"],
        )

        # Assert
        actual_event_record = actual_record.to_dynamodb_event_record()
        actual_event_source = actual_event_record["eventSource"]
        assert (
            actual_event_source == expected_event_source
        ), f"Expected eventSource '{expected_event_source}' but got '{actual_event_source}'"

    def test_record_contains_keys(self) -> None:
        # Arrange
        expected_keys = {"id": {"S": "item-5"}}

        # Act
        actual_record = build_stream_record(
            event_name=EventName.INSERT,
            table_name="test-table",
            keys=expected_keys,
            new_image={"id": {"S": "item-5"}},
            old_image=None,
            view_type=StreamViewType.NEW_AND_OLD_IMAGES,
            key_attributes=["id"],
        )

        # Assert
        actual_event_record = actual_record.to_dynamodb_event_record()
        actual_keys = actual_event_record["dynamodb"].get("Keys")
        assert (
            actual_keys == expected_keys
        ), f"Expected Keys '{expected_keys}' but got '{actual_keys}'"

    def test_lambda_event_envelope_has_records_list(self) -> None:
        # Arrange
        from lws.providers.dynamodb.streams import _build_lambda_event

        record = build_stream_record(
            event_name=EventName.INSERT,
            table_name="test-table",
            keys={"id": {"S": "item-6"}},
            new_image={"id": {"S": "item-6"}},
            old_image=None,
            view_type=StreamViewType.NEW_AND_OLD_IMAGES,
            key_attributes=["id"],
        )
        expected_records_count = 1

        # Act
        actual_event = _build_lambda_event([record])

        # Assert
        actual_records = actual_event.get("Records", [])
        actual_records_count = len(actual_records)
        assert actual_records_count == expected_records_count, (
            f"Expected {expected_records_count} record in Lambda event "
            f"but got {actual_records_count}"
        )
