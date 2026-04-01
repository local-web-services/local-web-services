"""Step Functions HTTP routes.

Implements the Step Functions wire protocol that AWS SDKs expect,
using JSON request/response format with X-Amz-Target header dispatch.
"""

from __future__ import annotations

from fastapi import APIRouter, FastAPI, Request, Response

from lws.interfaces.cloudtrail import ICloudTrail  # noqa: TC001
from lws.logging.logger import get_logger
from lws.logging.middleware import RequestLoggingMiddleware
from lws.providers._shared.aws_capacity import AwsCapacityConfig
from lws.providers._shared.aws_chaos import (
    AwsChaosConfig,
    AwsChaosMiddleware,
    ErrorFormat,
)
from lws.providers._shared.aws_cloudtrail_middleware import apply_cloudtrail_middleware
from lws.providers._shared.aws_iam_auth import IamAuthBundle, add_iam_auth_middleware
from lws.providers._shared.aws_lifecycle import (
    ResourceLifecycleConfig,
    ResourceStateTracker,
)
from lws.providers._shared.aws_operation_fake import (
    AwsFakeConfig,
    AwsOperationFakeMiddleware,
)
from lws.providers._shared.request_helpers import parse_json_body, resolve_api_action
from lws.providers.sqs.provider import SqsProvider
from lws.providers.stepfunctions._stepfunctions_helpers import (
    _error_response,
    _extract_state_machine_name,
    _format_execution,
    _format_execution_summary,
    _json_response,
    _parse_input,
    _unimplemented_sfn_action_response,
    check_sm_lifecycle,
)
from lws.providers.stepfunctions._stepfunctions_sqs_validator import check_sqs_task_targets
from lws.providers.stepfunctions.provider import StepFunctionsProvider

_logger = get_logger("ldk.stepfunctions")


class StepFunctionsRouter:
    """Route Step Functions API requests to a StepFunctionsProvider backend."""

    def __init__(
        self,
        provider: StepFunctionsProvider,
        lifecycle: ResourceLifecycleConfig | None = None,
        capacity: AwsCapacityConfig | None = None,
        sqs_provider: SqsProvider | None = None,
        sqs_tracker: ResourceStateTracker | None = None,
    ) -> None:
        self.provider = provider
        self._lifecycle = lifecycle or ResourceLifecycleConfig()
        self._tracker = ResourceStateTracker(self._lifecycle)
        self._capacity = capacity or AwsCapacityConfig()
        self._sqs_provider = sqs_provider
        self._sqs_tracker = sqs_tracker
        self.router = APIRouter()
        self.router.add_api_route("/", self._dispatch, methods=["POST"])

    @property
    def tracker(self) -> ResourceStateTracker:
        """Expose the lifecycle state tracker for cross-service use."""
        return self._tracker

    async def _dispatch(self, request: Request) -> Response:
        """Dispatch based on X-Amz-Target header or Action parameter."""
        target = request.headers.get("x-amz-target", "")
        body = await parse_json_body(request)
        action = resolve_api_action(target, body)

        handler = self._handlers().get(action)
        if handler is None:
            return _unimplemented_sfn_action_response(action)
        return await handler(body)

    def _handlers(self) -> dict:
        """Return map of action names to handler methods."""
        return {
            "StartExecution": self._start_execution,
            "StartSyncExecution": self._start_sync_execution,
            "DescribeExecution": self._describe_execution,
            "ListExecutions": self._list_executions,
            "ListStateMachines": self._list_state_machines,
            "CreateStateMachine": self._create_state_machine,
            "DeleteStateMachine": self._delete_state_machine,
            "DescribeStateMachine": self._describe_state_machine,
            "StopExecution": self._stop_execution,
            "UpdateStateMachine": self._update_state_machine,
            "GetExecutionHistory": self._get_execution_history,
            "ValidateStateMachineDefinition": self._validate_definition,
            "ListStateMachineVersions": self._list_state_machine_versions,
            "TagResource": self._tag_resource,
            "UntagResource": self._untag_resource,
            "ListTagsForResource": self._list_tags_for_resource,
        }

    # ------------------------------------------------------------------
    # Action handlers
    # ------------------------------------------------------------------

    async def _start_execution(self, body: dict) -> Response:
        """Handle StartExecution API action (STANDARD workflows only)."""
        if self._capacity.is_exhausted:
            return _error_response(
                "ServiceUnavailableException", "lws: no execution slots available"
            )

        sm_name = _extract_state_machine_name(body)
        input_data = _parse_input(body)
        execution_name = body.get("name")

        # Lifecycle: reject if SM is not in ACTIVE state
        lc_status = self._tracker.get_state(sm_name)
        if lc_status is not None and lc_status != "ACTIVE":
            if lc_status == "DELETING":
                return _error_response(
                    "StateMachineDoesNotExist",
                    f"State machine does not exist: {sm_name}",
                )
            return _error_response(
                "StateMachineDeleting",
                f"State machine '{sm_name}' is not ACTIVE (current state: {lc_status})",
            )

        wf_type = self.provider.get_workflow_type(sm_name)
        if wf_type is not None and wf_type != "STANDARD":
            return _error_response(
                "StateMachineTypeNotSupported",
                f"StartExecution is not supported for {wf_type} state machines; "
                "use StartSyncExecution for EXPRESS workflows.",
            )

        return await self._run_execution(sm_name, input_data, execution_name)

    async def _start_sync_execution(self, body: dict) -> Response:
        """Handle StartSyncExecution API action (EXPRESS workflows only)."""
        if self._capacity.is_exhausted:
            return _error_response(
                "ServiceUnavailableException", "lws: no execution slots available"
            )
        sm_name = _extract_state_machine_name(body)
        input_data = _parse_input(body)
        execution_name = body.get("name")

        wf_type = self.provider.get_workflow_type(sm_name)
        if wf_type is not None and wf_type != "EXPRESS":
            return _error_response(
                "StateMachineTypeNotSupported",
                f"StartSyncExecution is not supported for {wf_type} state machines; "
                "use StartExecution for STANDARD workflows.",
            )

        return await self._run_execution(sm_name, input_data, execution_name)

    async def _run_execution(
        self, sm_name: str, input_data: str | None, execution_name: str | None
    ) -> Response:
        """Call provider.start_execution and translate errors to HTTP responses."""
        try:
            result = await self.provider.start_execution(
                state_machine_name=sm_name,
                input_data=input_data,
                execution_name=execution_name,
            )
        except ValueError as exc:
            return _error_response(
                "StateMachineDeleting",
                f"State machine is not ACTIVE: {exc}",
            )
        except KeyError as exc:
            return _error_response("StateMachineDoesNotExist", str(exc))
        return _json_response(result)

    async def _describe_execution(self, body: dict) -> Response:
        """Handle DescribeExecution API action."""
        execution_arn = body.get("executionArn", "")
        history = self.provider.get_execution(execution_arn)
        if history is None:
            return _error_response("ExecutionDoesNotExist", f"Execution not found: {execution_arn}")
        return _json_response(_format_execution(history))

    async def _list_executions(self, body: dict) -> Response:
        """Handle ListExecutions API action."""
        sm_arn = body.get("stateMachineArn", "")
        sm_name = sm_arn.rsplit(":", 1)[-1] if ":" in sm_arn else sm_arn
        if sm_name:
            err = check_sm_lifecycle(sm_arn, self._tracker, self.provider)
            if err:
                return err
        executions = self.provider.list_executions(sm_name or None)
        items = [_format_execution_summary(h) for h in executions]
        return _json_response({"executions": items})

    async def _list_state_machines(self, _body: dict) -> Response:
        """Handle ListStateMachines API action."""
        names = self.provider.list_state_machines()
        machines = [
            {
                "name": n,
                "stateMachineArn": f"arn:aws:states:us-east-1:000000000000:stateMachine:{n}",
                "status": "ACTIVE",
            }
            for n in names
        ]
        return _json_response({"stateMachines": machines})

    async def _create_state_machine(self, body: dict) -> Response:
        """Handle CreateStateMachine API action."""
        name = body.get("name", "")
        definition = body.get("definition", "{}")
        role_arn = body.get("roleArn", "")
        sm_type = body.get("type", "STANDARD")

        if not name:
            return _error_response("ValidationException", "name is required")

        try:
            arn = self.provider.create_state_machine(
                name=name,
                definition=definition,
                role_arn=role_arn,
                workflow_type=sm_type,
            )
        except ValueError:
            return _error_response(
                "StateMachineAlreadyExists",
                f"State Machine Already Exists: {name}",
            )
        creation_date = __import__("time").time()
        # Lifecycle: track state; mutate response/provider only if dwell > 0
        status = "ACTIVE"
        if self._lifecycle.enabled:
            self._tracker.set_state(name, "CREATING")
            if self._lifecycle.create_dwell_ms > 0:
                self.provider.set_state_machine_status(name, "CREATING")
                _prov = self.provider
                _sm = name

                async def _activate_sm() -> None:
                    _prov.set_state_machine_status(_sm, "ACTIVE")

                self._tracker.schedule_transition(
                    name, "ACTIVE", self._lifecycle.create_dwell_ms, on_complete=_activate_sm
                )
                status = "CREATING"
            else:
                self._tracker.schedule_transition(name, "ACTIVE", 0)
        return _json_response(
            {
                "stateMachineArn": arn,
                "creationDate": creation_date,
                "stateMachineStatus": status,
            }
        )

    async def _delete_state_machine(self, body: dict) -> Response:
        """Handle DeleteStateMachine API action."""
        sm_arn = body.get("stateMachineArn", "")
        sm_name = sm_arn.rsplit(":", 1)[-1] if ":" in sm_arn else sm_arn

        # Lifecycle: block deletion if still CREATING
        lc_status = self._tracker.get_state(sm_name)
        if lc_status == "CREATING":
            return _error_response(
                "StateMachineDeleting",
                f"State machine '{sm_name}' is not yet ACTIVE",
            )

        try:
            self.provider.delete_state_machine(sm_name)
        except KeyError:
            return _error_response(
                "StateMachineDoesNotExist",
                f"State machine not found: {sm_arn}",
            )
        # Lifecycle: track DELETING state; return status in response only if dwell > 0
        if self._lifecycle.enabled:
            self._tracker.set_state(sm_name, "DELETING")
            self._tracker.schedule_transition(
                sm_name,
                None,  # remove from tracker after dwell (SM is already gone from store)
                self._lifecycle.delete_dwell_ms,
            )
            if self._lifecycle.delete_dwell_ms > 0:
                return _json_response({"stateMachineStatus": "DELETING"})
        return _json_response({})

    async def _describe_state_machine(self, body: dict) -> Response:
        """Handle DescribeStateMachine API action."""
        sm_arn = body.get("stateMachineArn", "")
        sm_name = sm_arn.rsplit(":", 1)[-1] if ":" in sm_arn else sm_arn

        # Check lifecycle state - reject if CREATING or DELETING
        lc_status = self._tracker.get_state(sm_name)
        if lc_status == "DELETING":
            return _error_response(
                "StateMachineDoesNotExist",
                f"State machine not found: {sm_arn}",
            )
        if lc_status == "CREATING":
            return _error_response(
                "StateMachineDeleting",
                f"State machine is not ACTIVE: {sm_arn}",
            )

        try:
            attrs = self.provider.describe_state_machine(sm_name)
        except KeyError:
            return _error_response(
                "StateMachineDoesNotExist",
                f"State machine not found: {sm_arn}",
            )
        # Override status from lifecycle tracker
        if lc_status is not None:
            attrs = dict(attrs)
            attrs["status"] = lc_status
        return _json_response(attrs)

    async def _validate_definition(self, _body: dict) -> Response:
        """Handle ValidateStateMachineDefinition — always valid."""
        return _json_response({"result": "OK", "diagnostics": []})

    async def _list_state_machine_versions(self, body: dict) -> Response:
        sm_arn = body.get("stateMachineArn", "")
        err = check_sm_lifecycle(sm_arn, self._tracker, self.provider)
        if err:
            return err
        return _json_response({"stateMachineVersions": []})

    async def _tag_resource(self, body: dict) -> Response:
        resource_arn = body.get("resourceArn", "")
        err = check_sm_lifecycle(resource_arn, self._tracker, self.provider)
        if err:
            return err
        tags = body.get("tags", [])
        self.provider.tag_resource(resource_arn, tags)
        return _json_response({})

    async def _untag_resource(self, body: dict) -> Response:
        resource_arn = body.get("resourceArn", "")
        err = check_sm_lifecycle(resource_arn, self._tracker, self.provider)
        if err:
            return err
        tag_keys = body.get("tagKeys", [])
        existing_tags = self.provider.list_tags_for_resource(resource_arn)
        existing_keys = {t["key"] for t in existing_tags}
        for key in tag_keys:
            if key not in existing_keys:
                return _error_response(
                    "ResourceNotFoundException",
                    f"Tag key not found on resource: {key}",
                )
        self.provider.untag_resource(resource_arn, tag_keys)
        return _json_response({})

    async def _list_tags_for_resource(self, body: dict) -> Response:
        resource_arn = body.get("resourceArn", "")
        err = check_sm_lifecycle(resource_arn, self._tracker, self.provider)
        if err:
            return err
        tags = self.provider.list_tags_for_resource(resource_arn)
        return _json_response({"tags": tags})

    async def _stop_execution(self, body: dict) -> Response:
        """Handle StopExecution API action."""
        execution_arn = body.get("executionArn", "")
        error = body.get("error")
        cause = body.get("cause")

        try:
            self.provider.stop_execution(
                execution_arn=execution_arn,
                error=error,
                cause=cause,
            )
        except KeyError:
            return _error_response(
                "ExecutionDoesNotExist",
                f"Execution not found: {execution_arn}",
            )
        return _json_response({"stopDate": __import__("time").time()})

    async def _update_state_machine(self, body: dict) -> Response:
        """Handle UpdateStateMachine API action."""
        sm_arn = body.get("stateMachineArn", "")
        sm_name = sm_arn.rsplit(":", 1)[-1] if ":" in sm_arn else sm_arn
        definition = body.get("definition")
        role_arn = body.get("roleArn")

        lc_status = self._tracker.get_state(sm_name)
        if lc_status == "DELETING":
            return _error_response(
                "StateMachineDoesNotExist",
                f"State machine not found: {sm_arn}",
            )
        if lc_status == "CREATING":
            return _error_response(
                "StateMachineDeleting",
                f"State machine is not ACTIVE: {sm_arn}",
            )

        if definition is not None:
            err = check_sqs_task_targets(definition, self._sqs_provider, self._sqs_tracker)
            if err is not None:
                return err

        try:
            update_date = self.provider.update_state_machine(
                name=sm_name,
                definition=definition,
                role_arn=role_arn,
            )
        except KeyError:
            return _error_response(
                "StateMachineDoesNotExist",
                f"State machine not found: {sm_arn}",
            )
        except ValueError as exc:
            return _error_response(
                "InvalidDefinition",
                str(exc),
            )
        return _json_response({"updateDate": update_date})

    async def _get_execution_history(self, body: dict) -> Response:
        """Handle GetExecutionHistory API action."""
        execution_arn = body.get("executionArn", "")
        max_results = body.get("maxResults")

        try:
            events = self.provider.get_execution_history(
                execution_arn=execution_arn,
                max_results=max_results,
            )
        except KeyError:
            return _error_response(
                "ExecutionDoesNotExist",
                f"Execution not found: {execution_arn}",
            )
        return _json_response({"events": events})


# ------------------------------------------------------------------
# App factory
# ------------------------------------------------------------------


def create_stepfunctions_app(
    provider: StepFunctionsProvider,
    chaos: AwsChaosConfig | None = None,
    aws_fake: AwsFakeConfig | None = None,
    iam_auth: IamAuthBundle | None = None,
    lifecycle: ResourceLifecycleConfig | None = None,
    tracker_ref: list[ResourceStateTracker] | None = None,
    capacity: AwsCapacityConfig | None = None,
    sqs_provider: SqsProvider | None = None,
    sqs_tracker: ResourceStateTracker | None = None,
    cloudtrail_provider: ICloudTrail | None = None,
) -> FastAPI:
    """Create a FastAPI application that speaks the Step Functions wire protocol.

    Args:
        tracker_ref: Optional single-element list; if provided, the lifecycle
            ``ResourceStateTracker`` used by this app is deposited at index 0
            so callers can share it with other services (e.g. EventBridge).
        capacity: Optional capacity configuration for slot-limit enforcement.
        sqs_provider: Optional SQS provider for validating SQS task queue existence
            in UpdateStateMachine calls.
        sqs_tracker: Optional SQS lifecycle tracker for validating queue state in
            UpdateStateMachine calls.
    """
    app = FastAPI()
    if aws_fake is not None:
        app.add_middleware(
            AwsOperationFakeMiddleware, fake_config=aws_fake, service="stepfunctions"
        )
    add_iam_auth_middleware(app, "stepfunctions", iam_auth, ErrorFormat.JSON)
    if chaos is not None:
        app.add_middleware(AwsChaosMiddleware, chaos_config=chaos, error_format=ErrorFormat.JSON)
    app.add_middleware(RequestLoggingMiddleware, logger=_logger, service_name="stepfunctions")
    sfn_router = StepFunctionsRouter(
        provider,
        lifecycle=lifecycle,
        capacity=capacity,
        sqs_provider=sqs_provider,
        sqs_tracker=sqs_tracker,
    )
    if tracker_ref is not None:
        tracker_ref.append(sfn_router.tracker)
    app.include_router(sfn_router.router)
    apply_cloudtrail_middleware(app, cloudtrail_provider, "stepfunctions")
    return app
