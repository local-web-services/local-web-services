"""Tests for EventSourceManager activation and deactivation."""

from __future__ import annotations

from unittest.mock import AsyncMock, MagicMock, patch

from lws.providers.lambda_runtime.event_source_manager import (
    EventSourceManager,
    _extract_function_name,
    _extract_queue_name,
    _extract_table_name,
)


class TestEventSourceManager:
    """EventSourceManager activate/deactivate operations."""

    async def test_activate_sqs_starts_poller(self) -> None:
        # Arrange
        queue_provider = AsyncMock()
        compute = AsyncMock()
        manager = EventSourceManager(
            queue_providers={"my-queue": queue_provider},
            stream_dispatchers={},
            compute_providers={"my-function": compute},
        )
        mapping = {
            "UUID": "test-uuid-1",
            "EventSourceArn": "arn:aws:sqs:us-east-1:000000000000:my-queue",
            "FunctionArn": "my-function",
            "BatchSize": 5,
        }

        # Act
        with patch(
            "lws.providers.lambda_runtime.event_source_manager.SqsEventSourcePoller"
        ) as mock_poller_cls:
            mock_poller = AsyncMock()
            mock_poller_cls.return_value = mock_poller
            await manager.activate(mapping)

        # Assert
        mock_poller.start.assert_awaited_once()

    async def test_deactivate_stops_poller(self) -> None:
        # Arrange
        queue_provider = AsyncMock()
        compute = AsyncMock()
        manager = EventSourceManager(
            queue_providers={"my-queue": queue_provider},
            stream_dispatchers={},
            compute_providers={"my-function": compute},
        )
        mapping = {
            "UUID": "test-uuid-2",
            "EventSourceArn": "arn:aws:sqs:us-east-1:000000000000:my-queue",
            "FunctionArn": "my-function",
        }
        with patch(
            "lws.providers.lambda_runtime.event_source_manager.SqsEventSourcePoller"
        ) as mock_poller_cls:
            mock_poller = AsyncMock()
            mock_poller_cls.return_value = mock_poller
            await manager.activate(mapping)

        # Act
        await manager.deactivate("test-uuid-2")

        # Assert
        mock_poller.stop.assert_awaited_once()

    async def test_activate_dynamodb_stream_registers_handler(self) -> None:
        # Arrange
        dispatcher = MagicMock()
        compute = AsyncMock()
        manager = EventSourceManager(
            queue_providers={},
            stream_dispatchers={"my-table": dispatcher},
            compute_providers={"my-function": compute},
        )
        mapping = {
            "UUID": "test-uuid-3",
            "EventSourceArn": "arn:aws:dynamodb:us-east-1:000000000000:table/my-table/stream/123",
            "FunctionArn": "my-function",
        }

        # Act
        manager._activate_dynamodb_stream(
            "test-uuid-3",
            mapping["EventSourceArn"],
            "my-function",
        )

        # Assert
        dispatcher.register_handler.assert_called_once()
        actual_table = dispatcher.register_handler.call_args[0][0]
        expected_table = "my-table"
        assert actual_table == expected_table

    async def test_stop_all_stops_all_pollers(self) -> None:
        # Arrange
        queue_provider = AsyncMock()
        compute = AsyncMock()
        manager = EventSourceManager(
            queue_providers={"q1": queue_provider, "q2": queue_provider},
            stream_dispatchers={},
            compute_providers={"f1": compute, "f2": compute},
        )
        with patch(
            "lws.providers.lambda_runtime.event_source_manager.SqsEventSourcePoller"
        ) as mock_poller_cls:
            mock_poller1 = AsyncMock()
            mock_poller2 = AsyncMock()
            mock_poller_cls.side_effect = [mock_poller1, mock_poller2]
            await manager.activate(
                {
                    "UUID": "u1",
                    "EventSourceArn": "arn:aws:sqs:us-east-1:000000000000:q1",
                    "FunctionArn": "f1",
                }
            )
            await manager.activate(
                {
                    "UUID": "u2",
                    "EventSourceArn": "arn:aws:sqs:us-east-1:000000000000:q2",
                    "FunctionArn": "f2",
                }
            )

        # Act
        await manager.stop_all()

        # Assert
        mock_poller1.stop.assert_awaited_once()
        mock_poller2.stop.assert_awaited_once()

    def test_extract_function_name_from_arn(self) -> None:
        # Act
        actual = _extract_function_name("arn:aws:lambda:us-east-1:000000000000:function:MyFunc")

        # Assert
        expected = "MyFunc"
        assert actual == expected

    def test_extract_function_name_plain(self) -> None:
        # Act
        actual = _extract_function_name("MyFunc")

        # Assert
        expected = "MyFunc"
        assert actual == expected

    def test_extract_queue_name(self) -> None:
        # Act
        actual = _extract_queue_name("arn:aws:sqs:us-east-1:000000000000:my-queue")

        # Assert
        expected = "my-queue"
        assert actual == expected

    def test_extract_table_name(self) -> None:
        # Act
        actual = _extract_table_name(
            "arn:aws:dynamodb:us-east-1:000000000000:table/my-table/stream/123"
        )

        # Assert
        expected = "my-table"
        assert actual == expected
