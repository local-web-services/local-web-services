"""Complex resource collector functions for the CDK assembly parser.

Contains collectors for resource types whose extraction logic is long
enough to warrant a dedicated module, keeping ``assembly.py`` under the
500-line limit.
"""

from __future__ import annotations

from lws.parser._assembly_helpers import resolve_sm_definition, resolve_substitutions
from lws.parser._assembly_nodes import (
    CognitoUserPool,
    EventRule,
    SqsQueue,
    StateMachine,
)
from lws.parser.ref_resolver import RefResolver
from lws.parser.template_parser import CfnResource


def collect_queues(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[SqsQueue]:
    """Extract SQS queues from parsed CloudFormation resources."""
    queues: list[SqsQueue] = []
    for r in resources:
        if r.resource_type != "AWS::SQS::Queue":
            continue
        props = r.properties
        name = props.get("QueueName", r.logical_id)
        if isinstance(name, dict):
            name = str(resolver.resolve(name))
        is_fifo = bool(props.get("FifoQueue", False))
        vis = int(props.get("VisibilityTimeout", 30))
        dedup = bool(props.get("ContentBasedDeduplication", False))
        redrive = props.get("RedrivePolicy")
        redrive_target = None
        max_receive = 5
        if isinstance(redrive, dict):
            dlq = redrive.get("deadLetterTargetArn", "")
            if isinstance(dlq, dict):
                dlq = str(resolver.resolve(dlq))
            redrive_target = str(dlq) if dlq else None
            max_receive = int(redrive.get("maxReceiveCount", 5))
        queues.append(
            SqsQueue(
                name=name,
                is_fifo=is_fifo,
                visibility_timeout=vis,
                content_based_dedup=dedup,
                redrive_target=redrive_target,
                max_receive_count=max_receive,
            )
        )
    return queues


def collect_event_rules(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[EventRule]:
    """Extract EventBridge rules from parsed CloudFormation resources."""
    rules: list[EventRule] = []
    for r in resources:
        if r.resource_type != "AWS::Events::Rule":
            continue
        props = r.properties
        rule_name = props.get("Name", r.logical_id)
        if isinstance(rule_name, dict):
            rule_name = str(resolver.resolve(rule_name))
        bus_name = props.get("EventBusName", "default")
        if isinstance(bus_name, dict):
            bus_name = str(resolver.resolve(bus_name))
        pattern = props.get("EventPattern")
        schedule = props.get("ScheduleExpression")
        raw_targets = props.get("Targets", [])
        targets: list[dict] = []
        for t in raw_targets:
            target_arn = t.get("Arn", "")
            if isinstance(target_arn, dict):
                target_arn = str(resolver.resolve(target_arn))
            targets.append(
                {
                    "target_id": t.get("Id", ""),
                    "arn": target_arn,
                    "input_path": t.get("InputPath"),
                    "input_template": t.get("InputTransformer", {}).get("InputTemplate"),
                }
            )
        rules.append(
            EventRule(
                rule_name=rule_name,
                event_bus_name=bus_name,
                event_pattern=pattern,
                schedule_expression=schedule,
                targets=targets,
            )
        )
    return rules


def collect_state_machines(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[StateMachine]:
    """Extract Step Functions state machines from parsed CloudFormation resources."""
    machines: list[StateMachine] = []
    for r in resources:
        if r.resource_type != "AWS::StepFunctions::StateMachine":
            continue
        props = r.properties
        name = props.get("StateMachineName", r.logical_id)
        if isinstance(name, dict):
            name = str(resolver.resolve(name))
        definition = props.get("DefinitionString", props.get("Definition", ""))
        definition = resolve_sm_definition(definition, resolver)
        role_arn = props.get("RoleArn", "")
        if isinstance(role_arn, dict):
            role_arn = str(resolver.resolve(role_arn))
        resolved_subs = resolve_substitutions(props.get("DefinitionSubstitutions", {}), resolver)
        machines.append(
            StateMachine(
                name=name,
                definition=definition,
                workflow_type=props.get("StateMachineType", "STANDARD"),
                role_arn=role_arn,
                definition_substitutions=resolved_subs,
            )
        )
    return machines


def collect_user_pools(
    resources: list[CfnResource],
    resolver: RefResolver,
) -> list[CognitoUserPool]:
    """Extract Cognito user pools from parsed CloudFormation resources."""
    pools: list[CognitoUserPool] = []
    client_map: dict[str, str] = {}
    for r in resources:
        if r.resource_type != "AWS::Cognito::UserPoolClient":
            continue
        pool_ref = r.properties.get("UserPoolId", "")
        if isinstance(pool_ref, dict):
            pool_ref = str(resolver.resolve(pool_ref))
        client_map[pool_ref] = r.logical_id

    for r in resources:
        if r.resource_type != "AWS::Cognito::UserPool":
            continue
        props = r.properties
        name = props.get("UserPoolName", r.logical_id)
        if isinstance(name, dict):
            name = str(resolver.resolve(name))
        lambda_config = props.get("LambdaConfig", {})
        pre_auth = lambda_config.get("PreAuthentication")
        if isinstance(pre_auth, dict):
            pre_auth = str(resolver.resolve(pre_auth))
        post_confirm = lambda_config.get("PostConfirmation")
        if isinstance(post_confirm, dict):
            post_confirm = str(resolver.resolve(post_confirm))
        pw_policy = props.get("Policies", {}).get("PasswordPolicy", {})
        client_id = client_map.get(r.logical_id, "")
        pools.append(
            CognitoUserPool(
                logical_id=r.logical_id,
                user_pool_name=name,
                auto_confirm=True,
                password_policy=pw_policy,
                pre_auth_trigger=pre_auth,
                post_confirm_trigger=post_confirm,
                client_id=client_id,
            )
        )
    return pools
