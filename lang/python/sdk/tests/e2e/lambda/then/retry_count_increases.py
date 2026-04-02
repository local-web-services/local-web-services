"""Then: the "lambda" "function" async retry count will increase"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "function" async retry count will increase')
def retry_count_increases(world):
    pytest.skip("Cannot observe Lambda async retry count in lws")
