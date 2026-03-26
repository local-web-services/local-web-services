"""Constants and shared helpers."""

from __future__ import annotations

import json
from typing import Any

from lws_testing import LwsSession

STATE_MACHINE_DEFINITION = json.dumps(
    {
        "Comment": "Simple order processor — passes input through as output",
        "StartAt": "ProcessOrder",
        "States": {
            "ProcessOrder": {
                "Type": "Pass",
                "End": True,
            }
        },
    }
)


class ScenarioContext:
    """Holds per-scenario state, shared across step definitions via the ctx fixture."""

    def __init__(self, shared: LwsSession) -> None:
        self.session: Any = shared
        self.sfn_client: Any = None
        self.state_machine_arn: str = ""
        self.last_output: dict | None = None
        self.last_error: Exception | None = None
        self.log_capture: Any = None
        self._log_capture_cm: Any = None
        self.sfn_fake_builder: Any = None
        self.fake_execution_arn: str = ""
        self.processed_outputs: list = []
        self.processed_ids: list = []
        self.ddb_helper: Any = None
        self.sqs_helper: Any = None
        self._dedicated_session_cm: Any = None
