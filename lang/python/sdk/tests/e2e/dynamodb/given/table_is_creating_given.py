"""Given: the "dynamodb" "table" was "CREATING" """

from __future__ import annotations

from pytest_bdd import given


@given('the "dynamodb" "table" was "CREATING"')
def table_is_creating_given(lws_session):
    """Enable lifecycle simulation so the next CreateTable call returns CREATING."""
    lws_session.lifecycle("dynamodb").create_dwell_ms(5000).apply()
