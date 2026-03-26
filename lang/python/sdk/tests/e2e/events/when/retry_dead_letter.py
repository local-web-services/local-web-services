"""When: a dead-letter queue entry is retried or discarded"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a dead-letter queue entry is retried or discarded")
def retry_dead_letter(world):
    pytest.skip("Cannot trigger dead-letter queue retry programmatically")
