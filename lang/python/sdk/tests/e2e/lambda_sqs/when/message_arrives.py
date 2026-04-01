"""When: a message arrives in the "sqs" "queue" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a message arrives in the "sqs" "queue"')
def message_arrives(world):
    pytest.skip("Cannot trigger internal message arrival in lws")
