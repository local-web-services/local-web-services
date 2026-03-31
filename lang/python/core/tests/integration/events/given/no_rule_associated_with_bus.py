"""Given: no rule is associated with the event bus."""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no eventbridge rule is associated with the "eventbridge" "bus"')
def no_rule_associated_with_bus():
    pytest.skip(
        "put_events does not fail when no rule is associated with the bus; "
        "it silently routes to zero targets"
    )
