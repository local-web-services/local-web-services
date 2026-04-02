"""Given: no "sqs" "message" "slot" was "available" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('no "sqs" "message" "slot" was "available"')
def no_message_slot_available():
    pytest.skip(
        "lws uses fire-and-forget notification delivery: put_object always succeeds"
        " regardless of SQS notification capacity"
    )
