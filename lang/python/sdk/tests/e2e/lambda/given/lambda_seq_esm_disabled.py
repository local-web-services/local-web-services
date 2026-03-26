"""Given: an enabled event source mapping has been disabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an enabled event source mapping has been disabled")
def lambda_seq_esm_disabled():
    pytest.skip("Cannot observe ESM state in lws without real event source")
