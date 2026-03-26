"""When: an "AWS" fake is deleted"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('an "AWS" fake is deleted')
def delete_aws_fake():
    pytest.skip("AWS fake service is not yet available in LwsSession")
