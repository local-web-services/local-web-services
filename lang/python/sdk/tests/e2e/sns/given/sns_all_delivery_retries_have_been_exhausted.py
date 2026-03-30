"""Given: all delivery retries have been exhausted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("all delivery retries have been exhausted")
def sns_all_delivery_retries_have_been_exhausted():
    pytest.skip("Cannot simulate exhausted delivery retries in lws")
