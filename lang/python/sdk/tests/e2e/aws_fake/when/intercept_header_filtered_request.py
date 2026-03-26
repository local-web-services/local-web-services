"""When: a request matching a header-filtered operation is intercepted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a request matching a header-filtered operation is intercepted")
def intercept_header_filtered_request():
    pytest.skip("AWS fake service is not yet available in LwsSession")
