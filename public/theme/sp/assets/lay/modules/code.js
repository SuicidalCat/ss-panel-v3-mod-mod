layui.define("jquery",function(e){"use strict";var a=layui.$;e("code",function(e){var l=[];e=e||{},e.elem=a(e.elem||".layui-code"),e.about=!("about"in e)||e.about,e.elem.each(function(){l.push(this)}),layui.each(l.reverse(),function(l,i){var t=a(i),c=t.html();(t.attr("lay-encode")||e.encode)&&(c=c.replace(/&(?!#?[a-zA-Z0-9]+;)/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/'/g,"&#39;").replace(/"/g,"&quot;")),t.html('<ol class="layui-code-ol"><li>'+c.replace(/[\r\t\n]+/g,"</li><li>")+"</li></ol>"),t.find(">.layui-code-h3")[0]||t.prepend("");var s=t.find(">.layui-code-ol");t.addClass("layui-box layui-code-view"),(t.attr("lay-skin")||e.skin)&&t.addClass("layui-code-"+(t.attr("lay-skin")||e.skin)),(s.find("li").length/100|0)>0&&s.css("margin-left",(s.find("li").length/100|0)+"px"),(t.attr("lay-height")||e.height)&&s.css("max-height",t.attr("lay-height")||e.height)})})}).addcss("modules/code.css","skincodecss");