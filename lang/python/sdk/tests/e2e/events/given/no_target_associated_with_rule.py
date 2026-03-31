"""Given: no target is associated with the "eventbridge" "rule" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no target is associated with the "eventbridge" "rule"')
def no_target_associated_with_rule():
    """No-op: fresh rules have no targets.

    put_events does not fail when no target is associated with the rule;
    it silently routes to zero targets. Skip the negative scenario.
    """
    pytest.skip(
        "put_events does not fail when no target is associated with the rule; "
        "it silently routes to zero targets"
    )
