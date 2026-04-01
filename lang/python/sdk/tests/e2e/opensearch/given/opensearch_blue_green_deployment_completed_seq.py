"""Given: a blue-green deployment completes"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a blue-green deployment completes")
def opensearch_blue_green_deployment_completed_seq():
    pytest.skip("Cannot trigger internal blue-green deployment completion in lws")
