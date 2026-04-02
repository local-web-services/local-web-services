"""When: a disabled "lambda" "event source mapping" was "ENABLED" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a disabled "lambda" "event source mapping" was "ENABLED"')
def enable_esm(lws_session, world):
    pytest.skip("Cannot enable ESM in lws without a real event source mapping UUID")
