"""Then: the message will be "IN_FLIGHT" and a Lambda invocation will be "IN_PROGRESS" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the message will be "IN_FLIGHT" and a Lambda invocation will be "IN_PROGRESS"')
def message_in_flight_invocation_in_progress(world):
    pytest.skip("Cannot observe ESM polling result in lws")
