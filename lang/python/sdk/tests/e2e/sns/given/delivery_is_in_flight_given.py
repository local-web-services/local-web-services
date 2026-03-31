"""Given: the "sns" "delivery" was "IN_FLIGHT" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sns" "delivery" was "IN_FLIGHT"')
def delivery_is_in_flight_given():
    pytest.skip("Cannot create in-flight delivery programmatically")
