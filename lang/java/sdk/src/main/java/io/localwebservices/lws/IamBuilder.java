package io.localwebservices.lws;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Configures IAM authentication mode for the local session via the
 * {@code /_ldk/iam-auth} management API.
 *
 * <p>Obtain a builder via {@link LwsSession#iam()}:
 * <pre>{@code
 * session.iam()
 *     .mode("enforce")
 *     .defaultIdentity("test-user")
 *     .identity("test-user")
 *         .allow(List.of("sfn:*"), "*")
 *         .apply()
 *     .apply();
 * }</pre>
 */
public class IamBuilder {

    /** Configures a single named IAM identity. */
    public class IdentityBuilder {
        private final String name;
        private final List<PolicyDoc> policies = new ArrayList<>();
        private PolicyDoc boundary;

        IdentityBuilder(String name) {
            this.name = name;
        }

        /** Adds an allow policy statement for the given actions and resource. */
        public IdentityBuilder allow(List<String> actions, String resource) {
            policies.add(new PolicyDoc("Allow", actions, resource));
            return this;
        }

        /** Adds a deny policy statement for the given actions and resource. */
        public IdentityBuilder deny(List<String> actions, String resource) {
            policies.add(new PolicyDoc("Deny", actions, resource));
            return this;
        }

        /** Sets a permissions boundary policy for the identity. */
        public IdentityBuilder boundary(List<String> actions, String resource) {
            this.boundary = new PolicyDoc("Allow", actions, resource);
            return this;
        }

        /** Registers this identity with the parent {@link IamBuilder} and returns it for chaining. */
        public IamBuilder apply() {
            return IamBuilder.this;
        }
    }

    private static class PolicyDoc {
        final String effect;
        final List<String> actions;
        final String resource;

        PolicyDoc(String effect, List<String> actions, String resource) {
            this.effect = effect;
            this.actions = actions;
            this.resource = resource;
        }
    }

    private final LwsSession session;
    private String mode;
    private String defaultIdentity;
    private final Map<String, IdentityBuilder> identities = new LinkedHashMap<>();

    IamBuilder(LwsSession session) {
        this.session = session;
    }

    /** Sets the IAM authentication mode (e.g. {@code "enforce"} or {@code "permissive"}). */
    public IamBuilder mode(String mode) {
        this.mode = mode;
        return this;
    }

    /** Sets the default identity used when no explicit identity is specified. */
    public IamBuilder defaultIdentity(String name) {
        this.defaultIdentity = name;
        return this;
    }

    /** Returns an {@link IdentityBuilder} for the named identity. */
    public IdentityBuilder identity(String name) {
        IdentityBuilder ib = new IdentityBuilder(name);
        identities.put(name, ib);
        return ib;
    }

    /** POSTs the IAM configuration to the {@code /_ldk/iam-auth} management API. */
    public void apply() throws Exception {
        String json = buildJson();
        URI uri = URI.create("http://127.0.0.1:" + session.getBasePort() + "/_ldk/iam-auth");
        HttpRequest request = HttpRequest.newBuilder(uri)
                .POST(HttpRequest.BodyPublishers.ofString(json))
                .header("Content-Type", "application/json")
                .timeout(Duration.ofSeconds(10))
                .build();
        HttpClient.newBuilder()
                .version(HttpClient.Version.HTTP_1_1)
                .build()
                .send(request, HttpResponse.BodyHandlers.discarding());
    }

    private String buildJson() {
        StringBuilder json = new StringBuilder("{");
        boolean firstField = true;

        if (mode != null) {
            json.append("\"mode\":\"").append(escape(mode)).append("\"");
            firstField = false;
        }
        if (defaultIdentity != null) {
            if (!firstField) json.append(",");
            json.append("\"default_identity\":\"").append(escape(defaultIdentity)).append("\"");
            firstField = false;
        }
        if (!identities.isEmpty()) {
            if (!firstField) json.append(",");
            json.append("\"identities\":{");
            boolean firstIdent = true;
            for (Map.Entry<String, IdentityBuilder> e : identities.entrySet()) {
                if (!firstIdent) json.append(",");
                json.append("\"").append(escape(e.getKey())).append("\":{");
                IdentityBuilder ib = e.getValue();
                boolean firstEntry = true;
                if (!ib.policies.isEmpty()) {
                    json.append("\"inline_policies\":[");
                    boolean firstPol = true;
                    for (PolicyDoc p : ib.policies) {
                        if (!firstPol) json.append(",");
                        json.append(serializePolicy(p));
                        firstPol = false;
                    }
                    json.append("]");
                    firstEntry = false;
                }
                if (ib.boundary != null) {
                    if (!firstEntry) json.append(",");
                    json.append("\"boundary_policy\":").append(serializePolicy(ib.boundary));
                }
                json.append("}");
                firstIdent = false;
            }
            json.append("}");
        }

        json.append("}");
        return json.toString();
    }

    private static String serializePolicy(PolicyDoc p) {
        StringBuilder sb = new StringBuilder("{");
        sb.append("\"Effect\":\"").append(escape(p.effect)).append("\"");
        sb.append(",\"Action\":[");
        boolean first = true;
        for (String a : p.actions) {
            if (!first) sb.append(",");
            sb.append("\"").append(escape(a)).append("\"");
            first = false;
        }
        sb.append("]");
        sb.append(",\"Resource\":\"").append(escape(p.resource)).append("\"");
        sb.append("}");
        return sb.toString();
    }

    private static String escape(String s) {
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
