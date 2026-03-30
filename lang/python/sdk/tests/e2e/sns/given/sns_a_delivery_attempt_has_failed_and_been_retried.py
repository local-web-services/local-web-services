"""Given: a delivery attempt has failed and been retried"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a delivery attempt has failed and been retried")
def sns_a_delivery_attempt_has_failed_and_been_retried():
    pytest.skip("Cannot pre-set delivery retry state in lws")
