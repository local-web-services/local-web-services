"""Tests for ServiceTaskBridge unsupported ARN handling."""

from __future__ import annotations

import pytest

from lws.providers.stepfunctions._service_task_bridge import ServiceTaskBridge


class TestServiceTaskBridgeInvokeUnsupported:
    """Unsupported ARNs raise RuntimeError."""

    async def test_unsupported_arn_raises(self) -> None:
        # Arrange
        expected_error_pattern = "Unsupported service integration ARN"
        bridge = ServiceTaskBridge({})

        # Act
        # Assert
        with pytest.raises(RuntimeError, match=expected_error_pattern):
            await bridge.invoke("arn:aws:states:::unknown:doSomething", {})
