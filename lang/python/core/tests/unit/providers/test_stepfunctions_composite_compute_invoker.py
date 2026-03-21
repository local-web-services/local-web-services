"""Tests for _CompositeComputeInvoker — routing between service bridge and Lambda bridge."""

from __future__ import annotations

from lws.providers.stepfunctions._service_task_bridge import _CompositeComputeInvoker

from ._helpers import FakeLambdaBridge, FakeServiceBridge


class TestCompositeComputeInvoker:
    """_CompositeComputeInvoker routes to the correct bridge."""

    async def test_service_arn_routed_to_service_bridge(self) -> None:
        # Arrange
        expected_arn = "arn:aws:states:::sqs:sendMessage"
        service_bridge = FakeServiceBridge(handled_arns={expected_arn})
        lambda_bridge = FakeLambdaBridge()
        invoker = _CompositeComputeInvoker(service_bridge, lambda_bridge)

        # Act
        result = await invoker.invoke_function(expected_arn, {})

        # Assert
        actual_service_arns = service_bridge.invoked_arns
        actual_lambda_arns = lambda_bridge.invoked_arns
        assert expected_arn in actual_service_arns
        assert len(actual_lambda_arns) == 0
        assert result == {"service": expected_arn}

    async def test_lambda_arn_routed_to_lambda_bridge(self) -> None:
        # Arrange
        expected_arn = "arn:aws:lambda:us-east-1:000000000000:function:my-func"
        service_bridge = FakeServiceBridge(handled_arns=set())
        lambda_bridge = FakeLambdaBridge()
        invoker = _CompositeComputeInvoker(service_bridge, lambda_bridge)

        # Act
        result = await invoker.invoke_function(expected_arn, {})

        # Assert
        actual_service_arns = service_bridge.invoked_arns
        actual_lambda_arns = lambda_bridge.invoked_arns
        assert len(actual_service_arns) == 0
        assert expected_arn in actual_lambda_arns
        assert result == {"lambda": expected_arn}

    async def test_service_bridge_takes_precedence_over_lambda_bridge(self) -> None:
        # Arrange
        expected_arn = "arn:aws:states:::dynamodb:putItem"
        service_bridge = FakeServiceBridge(handled_arns={expected_arn})
        lambda_bridge = FakeLambdaBridge()
        invoker = _CompositeComputeInvoker(service_bridge, lambda_bridge)

        # Act
        await invoker.invoke_function(expected_arn, {"TableName": "t", "Item": {}})

        # Assert
        actual_service_arns = service_bridge.invoked_arns
        actual_lambda_arns = lambda_bridge.invoked_arns
        assert expected_arn in actual_service_arns
        assert len(actual_lambda_arns) == 0

    async def test_multiple_calls_route_independently(self) -> None:
        # Arrange
        service_arn = "arn:aws:states:::sns:publish"
        lambda_arn = "arn:aws:lambda:us-east-1:000000000000:function:handler"
        service_bridge = FakeServiceBridge(handled_arns={service_arn})
        lambda_bridge = FakeLambdaBridge()
        invoker = _CompositeComputeInvoker(service_bridge, lambda_bridge)

        # Act
        await invoker.invoke_function(service_arn, {})
        await invoker.invoke_function(lambda_arn, {})

        # Assert
        actual_service_arns = service_bridge.invoked_arns
        actual_lambda_arns = lambda_bridge.invoked_arns
        assert service_arn in actual_service_arns
        assert lambda_arn in actual_lambda_arns
        assert lambda_arn not in actual_service_arns
        assert service_arn not in actual_lambda_arns
