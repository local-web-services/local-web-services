"""When: a "documentdb" "cluster" restore from documentdb snapshot completes"""

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a "documentdb" "cluster" restore from documentdb snapshot completes')
def cluster_restore_completes(lws_session, world):
    pytest.skip("Cannot trigger internal DocumentDB cluster restore completion in lws")
