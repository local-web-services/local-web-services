"""When: a message arrives in the "SQS" queue"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a message arrives in the "SQS" queue')
def message_arrives(world):
    pytest.skip("Cannot trigger internal message arrival in lws")
