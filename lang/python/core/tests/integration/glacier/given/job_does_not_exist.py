"""Given: the "glacier" "job" did not exist"""

from __future__ import annotations

from pytest_bdd import given

from ..constants import INT_VAULT_NAME


@given('the "glacier" "job" did not exist')
def job_does_not_exist(world):
    world["job_id"] = "nonexistent-job-id"
    if not world.get("vault_name"):
        world["vault_name"] = INT_VAULT_NAME
