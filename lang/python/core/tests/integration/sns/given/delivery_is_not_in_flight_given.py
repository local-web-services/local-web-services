"""Given: the "sns" "delivery" was not "IN_FLIGHT" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sns" "delivery" was not "IN_FLIGHT"')
def delivery_is_not_in_flight_given():
    pytest.skip("Cannot set delivery to non-IN_FLIGHT state")
