"""Given: a request for an operation not covered by the "AWS" fake has reached the provider"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a request for an operation not covered by the "AWS" fake has reached the provider')
def aws_fake_uncovered_request_reached_provider():
    pytest.skip("AWS fake service is not yet available in LwsSession")
