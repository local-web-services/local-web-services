"""Given: a "sns" "delivery" attempt fails and is retried"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "sns" "delivery" attempt fails and is retried')
def sns_a_delivery_attempt_has_failed_and_been_retried():
    pytest.skip("Cannot pre-set delivery retry state in lws")
