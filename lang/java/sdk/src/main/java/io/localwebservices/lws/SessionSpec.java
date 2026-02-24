package io.localwebservices.lws;

import java.util.ArrayList;
import java.util.List;

/** Declares the AWS resources to create in the local session. */
public class SessionSpec {

    private List<TableSpec> tables;
    private List<String> queues;
    private List<String> buckets;
    private List<String> topics;
    private List<StateMachineSpec> stateMachines;
    private List<String> parameters;
    private List<String> secrets;

    public SessionSpec tables(List<TableSpec> tables) { this.tables = tables; return this; }
    public SessionSpec queues(List<String> queues) { this.queues = queues; return this; }
    public SessionSpec buckets(List<String> buckets) { this.buckets = buckets; return this; }
    public SessionSpec topics(List<String> topics) { this.topics = topics; return this; }
    public SessionSpec stateMachines(List<StateMachineSpec> sms) { this.stateMachines = sms; return this; }
    public SessionSpec parameters(List<String> parameters) { this.parameters = parameters; return this; }
    public SessionSpec secrets(List<String> secrets) { this.secrets = secrets; return this; }

    public List<TableSpec> getTables() { return tables != null ? tables : new ArrayList<>(); }
    public List<String> getQueues() { return queues != null ? queues : new ArrayList<>(); }
    public List<String> getBuckets() { return buckets != null ? buckets : new ArrayList<>(); }
    public List<String> getTopics() { return topics != null ? topics : new ArrayList<>(); }
    public List<StateMachineSpec> getStateMachines() { return stateMachines != null ? stateMachines : new ArrayList<>(); }
    public List<String> getParameters() { return parameters != null ? parameters : new ArrayList<>(); }
    public List<String> getSecrets() { return secrets != null ? secrets : new ArrayList<>(); }

    public static SessionSpec empty() { return new SessionSpec(); }
}
