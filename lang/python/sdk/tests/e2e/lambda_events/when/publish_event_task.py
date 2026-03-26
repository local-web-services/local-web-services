"""When: the Lambda function publishes an event to the "ACTIVE" event bus and succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('the Lambda function publishes an event to the "ACTIVE" event bus and succeeds')
def publish_event_task(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
