"""Given: the "lambda" "function" async retry count had not been exhausted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "function" async retry count had not been exhausted')
def retry_count_not_exhausted():
    pytest.skip("Cannot observe Lambda async retry state in lws")
