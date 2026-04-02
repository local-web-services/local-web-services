"""Then: the "lambda" "invocation" will be "FAILED" with a ParameterNotFound error"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "lambda" "invocation" will be "FAILED" with a ParameterNotFound error')
def invocation_failed_param_not_found(world):
    pytest.skip("Cannot observe Lambda invocation failure in lws")
