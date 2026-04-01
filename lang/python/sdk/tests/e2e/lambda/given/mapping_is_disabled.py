"""Given: mapping_is_disabled"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('the mapping was "DISABLED"')
def mapping_is_disabled():
    pytest.skip("Cannot observe ESM DISABLED state in lws")
