"""When: a pending "lambda" "function" resolves its deployment"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a pending "lambda" "function" resolves its deployment')
def activate_function(world):
    pytest.skip("Cannot trigger Lambda PENDING->ACTIVE transition in lws")
