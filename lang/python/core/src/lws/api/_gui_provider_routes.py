"""Provider-related JavaScript sections for the LDK dashboard.

Exports string constants containing the JavaScript that renders the
Resources panel (providers, tables, queues, etc.) and the Invoke panel
(Lambda function invocation UI).
"""

from __future__ import annotations

_DASHBOARD_JS_RESOURCES = """\
// ── Resources ─────────────────────────────────────────────────────────────────
async function loadResources() {
  const panel = document.getElementById('resources-panel');
  try {
    const [r, s] = await Promise.all([
      fetch(BASE + '/_ldk/resources'), fetch(BASE + '/_ldk/status')
    ]);
    resourceData = await r.json();
    statusData = await s.json();
    renderResources(panel);
  } catch(err) {
    panel.innerHTML = '<div class="empty">Failed to load: ' + esc(err.message) + '</div>';
  }
}

function renderResources(panel) {
  if (!resourceData || !resourceData.services) {
    panel.innerHTML = '<div class="empty">No resources found.</div>';
    return;
  }
  invokeContexts = [];
  const health = {};
  if (statusData && statusData.providers)
    statusData.providers.forEach(p => { health[p.name] = p.healthy; });

  let html = '';
  for (const [svc, info] of Object.entries(resourceData.services)) {
    const h = health[svc];
    const hClass = h === true ? 'healthy' : h === false ? 'unhealthy' : '';
    const hText  = h === true ? '● healthy' : h === false ? '● unhealthy' : '';
    html += '<div class="svc-group">';
    html += '<div class="svc-head" data-toggle="svc">';
    html += '<span class="arrow">&#9654;</span> ';
    html += '<span class="svc-name">' + esc(svc) + '</span>';
    html += '<span class="svc-port">:' + (info.port||'?') + '</span>';
    if (hText) html += '<span class="svc-health ' + hClass + '">' + hText + '</span>';
    html += '</div><div class="svc-body">';
    if (info.resources && info.resources.length) {
      info.resources.forEach(res => {
        const name = res.name || res.path || '(unnamed)';
        html += '<div class="res-row"><span class="rn">' + esc(name) + '</span>';
        getOps(svc, res).forEach(op => {
          const idx = invokeContexts.length;
          invokeContexts.push({service:svc, port:info.port, resource:res, operation:op});
          html += '<button data-invoke="' + idx + '">' + esc(op) + '</button>';
        });
        html += '</div>';
      });
    } else {
      html += '<div class="res-row"><span class="rn" style="color:var(--fg2)">No resources</span></div>';
    }
    html += '</div></div>';
  }
  panel.innerHTML = html || '<div class="empty">No services running.</div>';
}

panel_el_res = document.getElementById('resources-panel');
panel_el_res.addEventListener('click', function(e) {
  const toggle = e.target.closest('[data-toggle="svc"]');
  if (toggle) {
    const arrow = toggle.querySelector('.arrow');
    if (arrow) arrow.classList.toggle('open');
    const body = toggle.nextElementSibling;
    if (body) body.style.display = body.style.display === 'none' ? '' : 'none';
    return;
  }
  const btn = e.target.closest('[data-invoke]');
  if (btn) {
    const ctx = invokeContexts[parseInt(btn.dataset.invoke, 10)];
    if (ctx) openInvoke(ctx);
  }
});

document.getElementById('btn-refresh').addEventListener('click', loadResources);

function getOps(svc, res) {
  switch(svc) {
    case 'dynamodb':     return ['Scan','GetItem','PutItem','DeleteItem'];
    case 'sqs':          return ['SendMessage','ReceiveMessage','PurgeQueue'];
    case 's3':           return ['ListObjects','GetObject','PutObject','DeleteObject'];
    case 'sns':          return ['Publish','ListSubscriptions'];
    case 'events':       return ['PutEvents','ListRules'];
    case 'stepfunctions':return ['StartExecution','ListExecutions'];
    case 'cognito-idp':  return ['ListUsers'];
    case 'apigateway':   return ['TestInvoke'];
    default:             return [];
  }
}

"""

_DASHBOARD_JS_INVOKE = """\
// ── Invoke ────────────────────────────────────────────────────────────────────
function openInvoke(ctx) {
  document.querySelectorAll('.tab').forEach(b => b.classList.remove('active'));
  document.querySelectorAll('[id][class~="panel"]').forEach(p => p.classList.remove('active'));
  document.querySelector('[data-tab="invoke"]').classList.add('active');
  document.getElementById('invoke').classList.add('active');
  renderInvoke(ctx);
}

function renderInvoke(ctx) {
  const ic = document.getElementById('invoke-panel');
  const svc = ctx.service, op = ctx.operation, res = ctx.resource;
  const resName = res.name || res.path || '';
  ic.innerHTML =
    '<div class="inv-hdr"><button id="btn-inv-back">← Back</button>' +
    '<strong>' + esc(svc.toUpperCase()) + '</strong> → ' +
    '<strong>' + esc(op) + '</strong> on <em>' + esc(resName) + '</em></div>' +
    '<div class="inv-form" id="inv-form">' + buildFields(svc, op, res) +
    '<div class="btn-row"><button class="inv-exec" id="btn-inv-exec">Execute</button></div></div>' +
    '<div id="inv-result" style="display:none"></div>';

  document.getElementById('btn-inv-back').addEventListener('click', () => {
    document.querySelector('[data-tab="resources"]').click();
  });
  document.getElementById('btn-inv-exec').addEventListener('click', () => runInvoke(ctx));
}

function buildFields(svc, op, res) {
  let h = '';
  switch(svc) {
    case 'dynamodb':
      if (op === 'Scan') return '';
      h += '<label>Key (JSON)</label><textarea id="f-key"></textarea>';
      if (op === 'PutItem') { h = '<label>Item (JSON)</label><textarea id="f-item"></textarea>'; }
      return h;
    case 'sqs':
      if (op === 'SendMessage')
        return '<label>Message Body</label><textarea id="f-body"></textarea>';
      return '';
    case 's3':
      if (op === 'GetObject' || op === 'DeleteObject')
        return '<label>Object Key</label><input id="f-key" placeholder="path/to/object.txt">';
      if (op === 'PutObject')
        return '<label>Object Key</label><input id="f-key" placeholder="path/to/object.txt">' +
               '<label>Body</label><textarea id="f-body"></textarea>';
      return '';
    case 'sns':
      if (op === 'Publish')
        return '<label>Message</label><textarea id="f-body"></textarea>' +
               '<label>Subject (optional)</label><input id="f-subject">';
      return '';
    case 'events':
      if (op === 'PutEvents')
        return '<label>Event Entry (JSON)</label><textarea id="f-body"></textarea>';
      return '';
    case 'stepfunctions':
      if (op === 'StartExecution')
        return '<label>Input (JSON)</label><textarea id="f-body" placeholder="{}"></textarea>';
      return '';
    case 'apigateway':
      return '<label>Method</label><input id="f-method" value="' + esc(res.method||'GET') + '">' +
             '<label>Path</label><input id="f-path" value="' + esc(res.path||'/') + '">' +
             '<label>Body (optional)</label><textarea id="f-body"></textarea>';
    default: return '';
  }
}

async function runInvoke(ctx) {
  const el = document.getElementById('inv-result');
  el.style.display = 'block'; el.className = ''; el.textContent = 'Executing…';
  try {
    const req = buildReq(ctx);
    const resp = await fetch(BASE + '/_ldk/service-proxy', {
      method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify(req)
    });
    const data = await resp.json();
    if (data.status >= 400) el.className = 'err';
    let body = data.body || '';
    try { body = JSON.stringify(JSON.parse(body), null, 2); } catch(_) {}
    el.textContent = 'Status: ' + data.status + '\\n\\n' + body;
  } catch(err) {
    el.className = 'err'; el.textContent = 'Error: ' + err.message;
  }
}

function val(id) { const e = document.getElementById(id); return e ? e.value : ''; }

function buildReq(ctx) {
  const {service:svc, operation:op, resource:res, port} = ctx;
  const base = 'http://localhost:' + port;
  switch(svc) {
    case 'dynamodb': {
      const body = {TableName:res.name};
      if (op === 'GetItem'||op === 'DeleteItem') body.Key = JSON.parse(val('f-key')||'{}');
      if (op === 'PutItem') body.Item = JSON.parse(val('f-item')||'{}');
      return {method:'POST', url:base+'/', headers:{
        'X-Amz-Target':'DynamoDB_20120810.'+op,
        'Content-Type':'application/x-amz-json-1.0'}, body:JSON.stringify(body)};
    }
    case 'sqs': {
      const qurl = res.queue_url||(base+'/000000000000/'+res.name);
      let p = 'Action='+op+'&QueueUrl='+encodeURIComponent(qurl);
      if (op === 'SendMessage') p += '&MessageBody='+encodeURIComponent(val('f-body')||'');
      return {method:'POST', url:base+'/', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:p};
    }
    case 's3': {
      const b = res.name;
      if (op === 'ListObjects')  return {method:'GET',    url:base+'/'+b+'?list-type=2', headers:{}, body:''};
      if (op === 'GetObject')    return {method:'GET',    url:base+'/'+b+'/'+val('f-key'), headers:{}, body:''};
      if (op === 'PutObject')    return {method:'PUT',    url:base+'/'+b+'/'+val('f-key'),
        headers:{'Content-Type':'application/octet-stream'}, body:val('f-body')||''};
      if (op === 'DeleteObject') return {method:'DELETE', url:base+'/'+b+'/'+val('f-key'), headers:{}, body:''};
      break;
    }
    case 'sns': {
      const arn = res.arn||'';
      let p = 'Action='+op+'&TopicArn='+encodeURIComponent(arn);
      if (op === 'Publish') {
        p += '&Message='+encodeURIComponent(val('f-body')||'');
        const subj = val('f-subject');
        if (subj) p += '&Subject='+encodeURIComponent(subj);
      }
      return {method:'POST', url:base+'/', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:p};
    }
    case 'events': {
      let body = {};
      if (op === 'PutEvents') {
        let entry = JSON.parse(val('f-body')||'{}');
        if (!entry.EventBusName) entry.EventBusName = res.arn||res.name;
        body = {Entries:[entry]};
      } else if (op === 'ListRules') { body = {EventBusName:res.arn||res.name}; }
      return {method:'POST', url:base+'/', headers:{
        'X-Amz-Target':'AWSEvents.'+op,'Content-Type':'application/x-amz-json-1.1'},
        body:JSON.stringify(body)};
    }
    case 'stepfunctions': {
      const arn = res.arn||'';
      const body = op === 'StartExecution'
        ? {stateMachineArn:arn, input:val('f-body')||'{}'}
        : {stateMachineArn:arn};
      return {method:'POST', url:base+'/', headers:{
        'X-Amz-Target':'AWSStepFunctions.'+op,'Content-Type':'application/x-amz-json-1.0'},
        body:JSON.stringify(body)};
    }
    case 'cognito-idp':
      return {method:'POST', url:base+'/', headers:{
        'X-Amz-Target':'AWSCognitoIdentityProviderService.'+op,
        'Content-Type':'application/x-amz-json-1.1'},
        body:JSON.stringify({UserPoolId:res.user_pool_id||''})};
    case 'apigateway':
      return {method:val('f-method')||'GET', url:base+(val('f-path')||'/'),
        headers:{'Content-Type':'application/json'}, body:val('f-body')||''};
  }
  return {method:'GET', url:base+'/', headers:{}, body:''};
}

"""
