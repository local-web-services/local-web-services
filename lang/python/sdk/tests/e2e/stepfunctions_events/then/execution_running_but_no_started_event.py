"""Then: the execution is "RUNNING" but no "STARTED" event is delivered"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the execution is "RUNNING" but no "STARTED" event is delivered')
def execution_running_but_no_started_event(world):
    pytest.skip("Cannot observe missing EventBridge event delivery in lws")
