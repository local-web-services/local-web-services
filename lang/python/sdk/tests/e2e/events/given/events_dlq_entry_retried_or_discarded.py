"""Given: a dead-letter queue entry has been retried or discarded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a dead-letter queue entry has been retried or discarded")
def events_dlq_entry_retried_or_discarded():
    pytest.skip("Cannot trigger dead-letter queue operations in lws")
