"""Given: all "sns" "delivery" retries are exhausted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('all "sns" "delivery" retries are exhausted')
def sns_all_delivery_retries_have_been_exhausted():
    pytest.skip("Cannot simulate exhausted delivery retries in lws")
