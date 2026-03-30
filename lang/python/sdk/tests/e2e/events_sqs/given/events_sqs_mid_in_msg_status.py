"""Given: mid in msg_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("mid in msg_status")
def events_sqs_mid_in_msg_status():
    pytest.skip("Cannot observe internal SQS message state in lws")
