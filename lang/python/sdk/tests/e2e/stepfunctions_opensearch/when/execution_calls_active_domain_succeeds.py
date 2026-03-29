"""When: a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a running execution calls an "ACTIVE" OpenSearch domain and the task succeeds')
def execution_calls_active_domain_succeeds(world):
    pytest.skip("Cannot trigger internal execution step that calls OpenSearch in lws")
