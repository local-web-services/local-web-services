"""When: a request matching an "AWS" fake operation is intercepted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a request matching an "AWS" fake operation is intercepted')
def intercept_aws_fake_request():
    pytest.skip("AWS fake service is not yet available in LwsSession")
