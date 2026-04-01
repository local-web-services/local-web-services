"""Then: the entry is removed from the dead-letter queue."""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the entry will be removed from the "eventbridge" "dead-letter queue"')
def entry_removed_from_dlq(world):
    pytest.skip("Cannot observe dead-letter queue retry result in integration test context")
