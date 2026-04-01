"""Given: the "lambda" "function" had a positive concurrency limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" had a positive concurrency limit')
def function_has_positive_concurrency_limit(world):
    pytest.skip("Cannot configure concurrency limit in integration tests.")
