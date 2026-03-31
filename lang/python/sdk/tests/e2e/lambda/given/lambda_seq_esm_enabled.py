"""Given: a disabled lambda event source mapping was "ENABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a disabled lambda event source mapping was "ENABLED"')
def lambda_seq_esm_enabled():
    pytest.skip("Cannot observe ESM state in lws without real event source")
