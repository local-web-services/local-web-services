"""Given: the "sqs" "message" was not "IN_FLIGHT" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sqs" "message" was not "IN_FLIGHT"')
def message_is_not_in_flight_given():
    pytest.skip("Cannot force a message into a non-IN_FLIGHT state externally")
