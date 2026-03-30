"""Given: a delivery attempt has succeeded"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a delivery attempt has succeeded")
def sns_a_delivery_attempt_has_succeeded():
    pytest.skip("Cannot pre-set delivery success state in lws")
