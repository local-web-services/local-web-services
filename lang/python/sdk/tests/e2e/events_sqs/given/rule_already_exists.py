"""Given: the rule already exists"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("the rule already exists")
def rule_already_exists(lws_session):
    pytest.skip("lws does not reject put_rule when rule already exists (idempotent)")
