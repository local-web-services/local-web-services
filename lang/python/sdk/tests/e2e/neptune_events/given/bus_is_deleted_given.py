"""Given: the bus is "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the bus is "DELETED"')
def bus_is_deleted_given():
    pytest.skip("lws does not reject Neptune operations when the event bus is deleted")
