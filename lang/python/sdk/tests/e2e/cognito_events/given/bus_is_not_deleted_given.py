"""Given: the "eventbridge" "bus" was not "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "eventbridge" "bus" was not "DELETED"')
def bus_is_not_deleted_given():
    pytest.skip("lws does not enforce event delivery failure when the bus is not deleted")
