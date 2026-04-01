"""Given: a "sns" "delivery" attempt succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a "sns" "delivery" attempt succeeds')
def sns_a_delivery_attempt_has_succeeded():
    pytest.skip("Cannot pre-set delivery success state in lws")
