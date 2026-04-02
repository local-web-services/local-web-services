"""Given: the "chaos" "error rate" is not set to full for the "service" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "chaos" "error rate" is not set to full for the "service"')
def error_rate_not_set_to_full():
    pytest.skip("LWS does not enforce rejection when error rate is not set to full")
