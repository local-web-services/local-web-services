"""Given: the dead-letter queue is not empty."""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "eventbridge" "dead-letter queue" was not empty')
def dlq_not_empty():
    pytest.skip("Cannot populate dead-letter queue programmatically in integration test context")
