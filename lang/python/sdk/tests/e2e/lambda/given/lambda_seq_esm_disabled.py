"""Given: an enabled "lambda" "event source mapping" was "DISABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('an enabled "lambda" "event source mapping" was "DISABLED"')
def lambda_seq_esm_disabled():
    pytest.skip("Cannot observe ESM state in lws without real event source")
