"""When: the Lambda function fails to publish because the event bus has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function fails to publish because the event bus has been deleted")
def invocation_fails_bus_deleted(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
