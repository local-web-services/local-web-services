"""Given: mid in mapping_status"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("mid in mapping_status")
def mid_in_mapping_status():
    pytest.skip("Cannot create ESM in lws without a real event source ARN")
