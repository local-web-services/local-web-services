"""Given: mid in msg_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("mid in msg_status")
def events_sns_mid_in_msg_status():
    pytest.skip("Cannot observe internal SNS message delivery state in lws")
