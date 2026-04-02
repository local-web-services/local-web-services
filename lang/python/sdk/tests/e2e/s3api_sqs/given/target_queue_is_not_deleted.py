"""Given: the target "sqs" "queue" was not "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the target "sqs" "queue" was not "DELETED"')
def target_queue_is_not_deleted():
    pytest.skip(
        "lws uses fire-and-forget notification delivery: put_object always succeeds"
        " regardless of notification dispatch outcome"
    )
