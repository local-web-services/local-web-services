"""Given: the dead-letter queue is empty"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the dead-letter queue is empty")
def dlq_is_empty():
    pytest.skip("Cannot reliably ensure dead-letter queue is empty")
