"""LWS CLI entry point.

Provides AWS CLI-style commands for interacting with local LDK resources.
Requires a running ``ldk dev`` instance.
"""

from __future__ import annotations

import typer

from ldk.cli.services.apigateway import app as apigateway_app
from ldk.cli.services.cognito import app as cognito_app
from ldk.cli.services.dynamodb import app as dynamodb_app
from ldk.cli.services.events import app as events_app
from ldk.cli.services.s3 import app as s3_app
from ldk.cli.services.sns import app as sns_app
from ldk.cli.services.sqs import app as sqs_app
from ldk.cli.services.stepfunctions import app as stepfunctions_app

app = typer.Typer(
    name="lws",
    help="AWS CLI-style commands for local LDK resources. Requires a running 'ldk dev' instance.",
)

app.add_typer(apigateway_app, name="apigateway")
app.add_typer(stepfunctions_app, name="stepfunctions")
app.add_typer(sqs_app, name="sqs")
app.add_typer(sns_app, name="sns")
app.add_typer(s3_app, name="s3api")
app.add_typer(dynamodb_app, name="dynamodb")
app.add_typer(events_app, name="events")
app.add_typer(cognito_app, name="cognito-idp")
