"""Then: mapping_is_deleted_then"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "event source mapping" will be deleted')
def mapping_is_deleted_then(world):
    pytest.skip("Cannot observe ESM DELETED state in lws")
