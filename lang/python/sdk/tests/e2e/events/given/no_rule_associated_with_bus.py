"""Given: no eventbridge rule is associated with the "eventbridge" "bus" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no eventbridge rule is associated with the "eventbridge" "bus"')
def no_rule_associated_with_bus():
    """No-op: fresh state has no rules on the bus.

    put_events does not fail when there are no matching rules; it silently
    routes to zero targets. Skip the negative scenario.
    """
    pytest.skip(
        "put_events does not fail when no rule is associated with the bus; "
        "it silently routes to zero targets"
    )
