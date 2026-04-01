"""When: a blue-green deployment completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when("a blue-green deployment completes")
def blue_green_complete(lws_session, world):
    pytest.skip("Cannot trigger internal blue-green deployment completion in lws")
