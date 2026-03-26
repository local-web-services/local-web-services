"""Given: a request matching a header-filtered operation has been intercepted"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a request matching a header-filtered operation has been intercepted")
def aws_fake_header_filtered_request_intercepted():
    pytest.skip("AWS fake service is not yet available in LwsSession")
