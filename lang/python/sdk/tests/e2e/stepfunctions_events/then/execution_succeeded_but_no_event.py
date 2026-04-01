"""Then: the "step functions" "execution" will be "SUCCEEDED" but no "SUCCEEDED" event will be delivered"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then(
    'the "step functions" "execution" will be "SUCCEEDED" but no "SUCCEEDED" event will be delivered'
)
def execution_succeeded_but_no_event(world):
    pytest.skip("Cannot observe missing EventBridge event delivery in lws")
