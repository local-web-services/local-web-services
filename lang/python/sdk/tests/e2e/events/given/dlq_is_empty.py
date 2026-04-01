"""Given: the "eventbridge" "dead-letter queue" was empty"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "eventbridge" "dead-letter queue" was empty')
def dlq_is_empty():
    pytest.skip("Cannot reliably ensure dead-letter queue is empty")
