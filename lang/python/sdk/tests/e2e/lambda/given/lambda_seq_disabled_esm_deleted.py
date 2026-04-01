"""Given: a disabled lambda event source mapping is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a disabled lambda event source mapping is deleted")
def lambda_seq_disabled_esm_deleted():
    pytest.skip("Cannot observe ESM state in lws without real event source")
