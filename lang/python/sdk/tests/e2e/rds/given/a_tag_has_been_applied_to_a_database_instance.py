"""Given: a tag has been applied to a database instance"""

from __future__ import annotations

import pytest
from pytest_bdd import given


@given("a tag has been applied to a database instance")
def a_tag_has_been_applied_to_a_database_instance():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
