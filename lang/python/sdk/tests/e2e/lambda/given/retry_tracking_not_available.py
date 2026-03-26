"""Given: retry tracking is not available for the slot"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("retry tracking is not available for the slot")
def retry_tracking_not_available():
    pytest.skip("Cannot observe Lambda async retry state in lws")
