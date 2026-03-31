"""When: all "sns" "delivery" retries are exhausted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('all "sns" "delivery" retries are exhausted')
def all_delivery_retries_exhausted(world):
    pytest.skip("Cannot exhaust all delivery retries in this context")
