"""Given: a "sqs" "message" visibility timeout expires"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "sqs" "message" visibility timeout expires')
def sqs_a_message_visibility_timeout_has_expired():
    pytest.skip("Cannot simulate visibility timeout expiry in lws")
