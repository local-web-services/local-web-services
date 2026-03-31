"""Given: the rule is not "ENABLED"."""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "eventbridge" "rule" was not "ENABLED"')
def rule_is_not_enabled_given():
    pytest.skip(
        "put_events does not fail when the matching rule is not ENABLED; "
        "disabled rules are silently skipped during event routing"
    )
