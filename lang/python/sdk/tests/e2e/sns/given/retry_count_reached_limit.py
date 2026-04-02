"""Given: the "sns" "delivery" retry count had reached the limit"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "sns" "delivery" retry count had reached the limit')
def retry_count_reached_limit():
    pytest.skip("Cannot control retry count in this context")
