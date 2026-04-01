"""Given: the rule's event bus does not match."""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "eventbridge" "rule"\'s event eventbridge bus does not match')
def rules_event_bus_does_not_match():
    pytest.skip(
        "put_events does not fail when a rule's event bus does not match; "
        "it silently skips non-matching rules"
    )
