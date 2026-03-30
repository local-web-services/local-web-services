"""Given: no target is associated with the rule."""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("no target is associated with the rule")
def no_target_associated_with_rule():
    pytest.skip(
        "put_events does not fail when no target is associated with the rule; "
        "it silently routes to zero targets"
    )
