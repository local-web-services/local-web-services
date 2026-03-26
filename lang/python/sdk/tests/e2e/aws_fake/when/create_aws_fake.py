"""When: an "AWS" fake is created for a service"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "AWS" fake is created for a service')
def create_aws_fake():
    pytest.skip("AWS fake service is not yet available in LwsSession")
