"""Given: a disabled event source mapping has been enabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a disabled event source mapping has been enabled")
def lambda_seq_esm_enabled():
    pytest.skip("Cannot observe ESM state in lws without real event source")
