"""Tests for DynamoDB Streams emulation (P1-26)."""

from __future__ import annotations

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# StreamRecord tests
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# build_stream_record with StreamViewType tests
# ---------------------------------------------------------------------------
# ---------------------------------------------------------------------------
# StreamDispatcher tests
# ---------------------------------------------------------------------------
from lws.providers.dynamodb.streams import (
    EventName,
    StreamViewType,
    build_stream_record,
)


class TestBuildStreamRecord:
    """Test build_stream_record with different StreamViewTypes."""

    def _base_args(self) -> dict:
        return {
            "event_name": EventName.INSERT,
            "table_name": "users",
            "keys": {"userId": "u1"},
            "new_image": {"userId": "u1", "name": "Alice", "email": "a@b.com"},
            "old_image": None,
            "key_attributes": ["userId"],
        }

    def test_new_and_old_images(self) -> None:
        args = self._base_args()
        args["old_image"] = {"userId": "u1", "name": "OldAlice"}
        record = build_stream_record(
            **args,
            view_type=StreamViewType.NEW_AND_OLD_IMAGES,
        )
        assert record.new_image is not None
        assert record.old_image is not None

    def test_new_image_only(self) -> None:
        args = self._base_args()
        args["old_image"] = {"userId": "u1", "name": "OldAlice"}
        record = build_stream_record(
            **args,
            view_type=StreamViewType.NEW_IMAGE,
        )
        assert record.new_image is not None
        assert record.old_image is None

    def test_old_image_only(self) -> None:
        args = self._base_args()
        args["old_image"] = {"userId": "u1", "name": "OldAlice"}
        record = build_stream_record(
            **args,
            view_type=StreamViewType.OLD_IMAGE,
        )
        assert record.new_image is None
        assert record.old_image is not None

    def test_keys_only(self) -> None:
        args = self._base_args()
        args["old_image"] = {"userId": "u1", "name": "OldAlice"}
        record = build_stream_record(
            **args,
            view_type=StreamViewType.KEYS_ONLY,
        )
        assert record.new_image is None
        assert record.old_image is None

    def test_event_id_generated(self) -> None:
        args = self._base_args()
        record = build_stream_record(
            **args,
            view_type=StreamViewType.NEW_AND_OLD_IMAGES,
        )
        assert record.event_id  # non-empty
        assert record.sequence_number  # non-empty
