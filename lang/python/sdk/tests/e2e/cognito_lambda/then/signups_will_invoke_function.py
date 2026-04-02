"""Then: all subsequent signups will synchronously invoke the "lambda" "function" before confirming"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('all subsequent signups will synchronously invoke the "lambda" "function" before confirming')
def signups_will_invoke_function():
    pytest.skip("Cannot configure Lambda triggers for Cognito in lws")
