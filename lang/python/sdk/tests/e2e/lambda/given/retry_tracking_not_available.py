"""Given: "lambda" "async" "slot" retry tracking was not available"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('"lambda" "async" "slot" retry tracking was not available')
def retry_tracking_not_available():
    pytest.skip("Cannot observe Lambda async retry state in lws")
