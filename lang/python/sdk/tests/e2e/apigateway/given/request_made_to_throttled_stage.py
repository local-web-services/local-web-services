"""Given: a request has been made to the throttled prod stage"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a request has been made to the throttled prod stage")
def request_made_to_throttled_stage():
    pytest.skip("Cannot represent a throttled request as sequence setup in lws")
