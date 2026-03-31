"""When: a "lambda" "function" finishes being deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "lambda" "function" finishes being deleted')
def finish_delete_function(world):
    pytest.skip("Cannot trigger Lambda DELETING->DELETED transition in lws")
