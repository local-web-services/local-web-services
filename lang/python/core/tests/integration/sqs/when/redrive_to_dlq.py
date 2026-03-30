"""When: a message exceeding its receive count is moved to the dead-letter queue"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a message exceeding its receive count is moved to the dead-letter queue")
def redrive_to_dlq(world):
    pytest.skip("Cannot trigger DLQ redrive programmatically in integration test context")
