import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestListBuckets:
    def test_list_buckets(self, e2e_port, lws_invoke):
        # Arrange
        bucket_name = "e2e-list-bkts"
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket_name, "--port", str(e2e_port)])

        # Act
        result = runner.invoke(
            app,
            [
                "s3api",
                "list-buckets",
                "--port",
                str(e2e_port),
            ],
        )

        # Assert
        assert result.exit_code == 0, result.output
        data = json.loads(result.output)
        buckets = data["ListAllMyBucketsResult"]["Buckets"].get("Bucket", [])
        if isinstance(buckets, dict):
            buckets = [buckets]
        actual_names = [b["Name"] for b in buckets]
        assert bucket_name in actual_names
