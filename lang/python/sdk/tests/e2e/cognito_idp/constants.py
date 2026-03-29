"""Constants and shared helpers."""

from __future__ import annotations

import pytest
from botocore.exceptions import ClientError

TEST_POOL_NAME = "e2e-test-pool-1"

TEST_USERNAME = "e2e-test-user-1@example.com"

TEST_PASSWORD = "Test1234!"

TEST_TEMP_PASSWORD = "TempPass1!"

TEST_GROUP_NAME = "e2e-test-group-1"


def _skip_if_not_implemented(exc):
    """Skip the test if the Cognito operation is not yet implemented in lws."""
    if isinstance(exc, ClientError):
        code = exc.response["Error"]["Code"]
        if code == "UnknownOperationException":
            msg = exc.response["Error"]["Message"]
            pytest.skip(f"Cognito operation not yet implemented in lws: {msg}")
