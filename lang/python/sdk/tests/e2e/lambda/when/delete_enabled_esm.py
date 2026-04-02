"""When: an enabled "lambda" "event source mapping" is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an enabled "lambda" "event source mapping" is deleted')
def delete_enabled_esm(lws_session, world):
    pytest.skip("Cannot delete ESM in lws without a real event source mapping UUID")
