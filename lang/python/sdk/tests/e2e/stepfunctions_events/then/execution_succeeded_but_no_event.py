"""Then: the execution is "SUCCEEDED" but no "SUCCEEDED" event is delivered"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the execution is "SUCCEEDED" but no "SUCCEEDED" event is delivered')
def execution_succeeded_but_no_event(world):
    pytest.skip("Cannot observe missing EventBridge event delivery in lws")
