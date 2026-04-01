"""Given: len(dlq) > 0"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("len(dlq) > 0")
def events_dlq_not_empty():
    pytest.skip("Cannot observe dead-letter queue state in lws")
