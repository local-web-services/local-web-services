"""Given: an enabled event source mapping has been deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("an enabled event source mapping has been deleted")
def lambda_seq_enabled_esm_deleted():
    pytest.skip("Cannot observe ESM state in lws without real event source")
