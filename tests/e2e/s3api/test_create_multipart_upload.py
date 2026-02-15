"""E2E test for S3 multipart upload workflow via CLI commands."""

import json

from typer.testing import CliRunner

from lws.cli.lws import app

runner = CliRunner()


class TestCreateMultipartUpload:
    def test_full_multipart_workflow(self, e2e_port, tmp_path, lws_invoke, parse_output):
        # Arrange
        bucket = "e2e-multipart"
        key = "e2e-multi.bin"
        part1_content = b"first-part-"
        part2_content = b"second-part"
        expected_body = part1_content + part2_content
        lws_invoke(["s3api", "create-bucket", "--bucket", bucket, "--port", str(e2e_port)])

        # Act - create multipart upload
        create_result = runner.invoke(
            app,
            [
                "s3api",
                "create-multipart-upload",
                "--bucket",
                bucket,
                "--key",
                key,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert - initiate succeeded
        assert create_result.exit_code == 0, create_result.output
        create_body = parse_output(create_result.output)
        upload_id = create_body["InitiateMultipartUploadResult"]["UploadId"]

        # Act - upload part 1
        part1_file = tmp_path / "part1.bin"
        part1_file.write_bytes(part1_content)
        upload1_result = runner.invoke(
            app,
            [
                "s3api",
                "upload-part",
                "--bucket",
                bucket,
                "--key",
                key,
                "--upload-id",
                upload_id,
                "--part-number",
                "1",
                "--body",
                str(part1_file),
                "--port",
                str(e2e_port),
            ],
        )

        # Assert - part 1 uploaded
        assert upload1_result.exit_code == 0, upload1_result.output
        etag1 = parse_output(upload1_result.output)["ETag"]

        # Act - upload part 2
        part2_file = tmp_path / "part2.bin"
        part2_file.write_bytes(part2_content)
        upload2_result = runner.invoke(
            app,
            [
                "s3api",
                "upload-part",
                "--bucket",
                bucket,
                "--key",
                key,
                "--upload-id",
                upload_id,
                "--part-number",
                "2",
                "--body",
                str(part2_file),
                "--port",
                str(e2e_port),
            ],
        )

        # Assert - part 2 uploaded
        assert upload2_result.exit_code == 0, upload2_result.output
        etag2 = parse_output(upload2_result.output)["ETag"]

        # Act - complete multipart upload
        parts_json = json.dumps(
            {
                "Parts": [
                    {"PartNumber": 1, "ETag": etag1},
                    {"PartNumber": 2, "ETag": etag2},
                ]
            }
        )
        complete_result = runner.invoke(
            app,
            [
                "s3api",
                "complete-multipart-upload",
                "--bucket",
                bucket,
                "--key",
                key,
                "--upload-id",
                upload_id,
                "--multipart-upload",
                parts_json,
                "--port",
                str(e2e_port),
            ],
        )

        # Assert - complete succeeded, object readable
        assert complete_result.exit_code == 0, complete_result.output
        outfile = tmp_path / "verify.bin"
        verify_result = runner.invoke(
            app,
            [
                "s3api",
                "get-object",
                "--bucket",
                bucket,
                "--key",
                key,
                str(outfile),
                "--port",
                str(e2e_port),
            ],
        )
        assert verify_result.exit_code == 0, verify_result.output
        actual_body = outfile.read_bytes()
        assert actual_body == expected_body
