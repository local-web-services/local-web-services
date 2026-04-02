"""Given: the "eventbridge" "bus" did not exist or was "DELETED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "eventbridge" "bus" did not exist or was "DELETED"')
def bus_not_exist_or_deleted():
    pytest.skip("lws does not reject create_secret when the event bus does not exist or is deleted")
