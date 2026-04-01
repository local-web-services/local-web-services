"""When: a node failure occurs in an active "elasticsearch" "domain" """

from __future__ import annotations

import pytest
from pytest_bdd import when


@when('a node failure occurs in an active "elasticsearch" "domain"')
def node_failure(lws_session, world):
    pytest.skip("Cannot trigger internal node failure in lws")
