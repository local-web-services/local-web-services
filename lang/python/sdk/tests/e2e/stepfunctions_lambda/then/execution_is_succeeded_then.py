"""Then: the execution will be "SUCCEEDED" """

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the execution will be "SUCCEEDED"')
def execution_is_succeeded_then():
    pytest.skip("Cannot observe internal execution Lambda task success in lws")
