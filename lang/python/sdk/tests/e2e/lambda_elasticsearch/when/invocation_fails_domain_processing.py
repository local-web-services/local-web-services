"""When: the Lambda function fails to write because the domain is processing a config update"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("the Lambda function fails to write because the domain is processing a config update")
def invocation_fails_domain_processing(world):
    pytest.skip("Cannot trigger Lambda invocation in lws")
