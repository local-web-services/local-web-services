"""When: a request for an operation not covered by the "AWS" fake reaches the provider"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a request for an operation not covered by the "AWS" fake reaches the provider')
def fallthrough_request_reaches_provider():
    pytest.skip("AWS fake service is not yet available in LwsSession")
