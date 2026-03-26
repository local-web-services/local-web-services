"""When: the Lambda function fails to connect because the DocumentDB cluster is stopped"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function fails to connect because the DocumentDB cluster is stopped")
def invocation_fails_cluster_stopped(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
