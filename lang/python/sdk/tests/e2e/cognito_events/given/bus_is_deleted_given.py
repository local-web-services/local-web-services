"""Given: the bus was "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the bus was "DELETED"')
def bus_is_deleted_given():
    pytest.skip("lws does not reject Cognito operations when the event bus is deleted")
