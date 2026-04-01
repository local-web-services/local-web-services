"""Given: a tag is applied to a "rds" "instance" """

from __future__ import annotations

import pytest
from pytest_bdd import given


@given('a tag is applied to a "rds" "instance"')
def a_tag_has_been_applied_to_a_database_instance():
    pytest.skip("lws cluster_db_service does not implement boto3 RDS query protocol")
