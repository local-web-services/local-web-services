"""Then: the "eventbridge" "event" delivery "FAILED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "eventbridge" "event" delivery "FAILED"')
def event_delivery_failed():
    pytest.skip("Cannot observe internal Cognito event delivery failure in lws")
