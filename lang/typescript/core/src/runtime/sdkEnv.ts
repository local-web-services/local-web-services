/**
 * SDK endpoint redirection environment builder.
 *
 * Builds environment variable dictionaries that redirect AWS SDK calls to
 * local service endpoints provided by LWS.
 *
 * Mirrors `runtime/sdk_env.py`.
 */

/** Maps lowercase LWS service names to the AWS SDK env var suffix. */
const SERVICE_ID_MAP: Record<string, string> = {
  secretsmanager: "SECRETS_MANAGER",
  stepfunctions: "SFN",
  states: "SFN",
  "cognito-idp": "COGNITO_IDENTITY_PROVIDER",
  events: "EVENTBRIDGE",
};

/**
 * Build an environment dict that redirects AWS SDK calls to local endpoints.
 *
 * For each service in `endpoints`, creates an `AWS_ENDPOINT_URL_<SERVICE>`
 * variable using the AWS SDK's canonical service ID.  The returned dict always
 * includes dummy credentials and a default region so the SDK never falls back
 * to real AWS credentials.
 *
 * @param endpoints - Map of lowercase service names to their local URLs,
 *   e.g. `{ dynamodb: "http://localhost:3001" }`.
 */
export function buildSdkEnv(endpoints: Record<string, string>): Record<string, string> {
  const env: Record<string, string> = {
    AWS_ACCESS_KEY_ID: "ldk-local",
    AWS_SECRET_ACCESS_KEY: "ldk-local",
    AWS_DEFAULT_REGION: "us-east-1",
    AWS_REGION: "us-east-1",
  };

  for (const [serviceName, url] of Object.entries(endpoints)) {
    const sdkId = SERVICE_ID_MAP[serviceName] ?? serviceName.toUpperCase();
    env[`AWS_ENDPOINT_URL_${sdkId}`] = url;
  }

  if ("s3" in endpoints) {
    env["AWS_S3_FORCE_PATH_STYLE"] = "true";
  }

  return env;
}
