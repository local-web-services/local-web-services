"""Then: the "api gateway" "API" will synchronously invoke the function when a request arrives"""

from __future__ import annotations

import pytest
from pytest_bdd import then


@then('the "api gateway" "API" will synchronously invoke the function when a request arrives')
def api_will_invoke_function():
    pytest.skip("Cannot configure Lambda integration on REST API in lws")
