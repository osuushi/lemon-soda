(function(){var n,e,t,r,u,o,i,s=function(n,e){return function(){return n.apply(e,arguments)}};this.LemonSoda=new(function(){function r(){this.load=s(this.load,this)}return r.prototype.load=function(n){return t(n,function(n){return e(function(){return LemonSoda.processSprites(n)})})},r.prototype.processSprites=function(t){var r,u,o,i,s;r=50,i=new Date,s=[];for(u in t){if(o=t[u],n("."+u,"            background: url("+o.uri+") no-repeat;            width:"+o.w+"px;            height:"+o.h+"px;"),delete t[u],new Date-i>=r){e(function(){return LemonSoda.processSprites(t)});break}s.push(void 0)}return s},r}()),e=function(n){return setTimeout(n,1)},t=function(n,e){var t;return t=new XMLHttpRequest,t.onload=function(){return e(JSON.parse(this.responseText))},t.open("get",n,!0),t.send()},o=null!=(i=document.head)?i:document.body,o.appendChild(u=document.createElement("style")),r=u.sheet,null!=r&&(r.addRule?n=function(n,e){return r.addRule(n,e)}:r.insertRule&&(n=function(n,e){return r.insertRule(""+n+" { "+e+" }",0)})),null==n&&(n=function(n,e){return u.innerText+=""+n+" { "+e+" }"})}).call(this);