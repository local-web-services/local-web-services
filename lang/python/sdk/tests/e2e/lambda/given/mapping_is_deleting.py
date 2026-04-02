"""Given: mapping_is_deleting"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the "lambda" "event source mapping" was "DELETING"')
def mapping_is_deleting():
    pytest.skip("Cannot observe ESM DELETING state in lws")
