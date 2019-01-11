layui.define(["element","common"],function(i){"use strict";function e(i){for(var e='<ul class="layui-nav layui-nav-tree beg-navbar">',a=0;a<i.length;a++){if(i[a].spread?e+='<li class="layui-nav-item layui-nav-itemed">':e+='<li class="layui-nav-item">',void 0!==i[a].children&&null!==i[a].children&&i[a].children.length>0){e+='<a href="javascript:;">',void 0!==i[a].icon&&""!==i[a].icon&&(-1!==i[a].icon.indexOf("fa-")?e+='<i class="fa '+i[a].icon+'" aria-hidden="true" data-icon="'+i[a].icon+'"></i>':e+='<i class="layui-icon" data-icon="'+i[a].icon+'">'+i[a].icon+"</i>"),e+="<cite>"+i[a].title+"</cite>",e+="</a>",e+='<dl class="layui-nav-child">';for(var n=0;n<i[a].children.length;n++)e+='<dd title="'+i[a].children[n].title+'">',e+='<a href="javascript:;" data-url="'+i[a].children[n].href+'">',void 0!==i[a].children[n].icon&&""!==i[a].children[n].icon&&(-1!==i[a].children[n].icon.indexOf("fa-")?e+='<i class="fa '+i[a].children[n].icon+'" data-icon="'+i[a].children[n].icon+'" aria-hidden="true"></i>':e+='<i class="layui-icon" data-icon="'+i[a].children[n].icon+'">'+i[a].children[n].icon+"</i>"),e+="<cite>"+i[a].children[n].title+"</cite>",e+="</a>",e+="</dd>";e+="</dl>"}else{e+='<a href="javascript:;" '+(void 0!==i[a].href&&""!==i[a].href?'data-url="'+i[a].href+'"':"")+">",void 0!==i[a].icon&&""!==i[a].icon&&(-1!==i[a].icon.indexOf("fa-")?e+='<i class="fa '+i[a].icon+'" aria-hidden="true" data-icon="'+i[a].icon+'"></i>':e+='<i class="layui-icon" data-icon="'+i[a].icon+'">'+i[a].icon+"</i>"),e+="<cite>"+i[a].title+"</cite>",e+="</a>"}e+="</li>"}return e+="</ul>"}var a=layui.jquery,n=(void 0===parent.layer?layui.layer:parent.layer,layui.element()),r=layui.common,t=function(){this.config={elem:void 0,data:void 0,url:void 0,type:"GET",cached:!1,spreadOne:!1},this.v="1.0.0"};t.prototype.render=function(){var i=this,t=i.config;"string"!=typeof t.elem&&"object"!=typeof t.elem&&r.throwError("Navbar error: elem参数未定义或设置出错，具体设置格式请参考文档API.");var c;if("string"==typeof t.elem&&(c=a(""+t.elem)),"object"==typeof t.elem&&(c=t.elem),0===c.length&&r.throwError("Navbar error:找不到elem参数配置的容器，请检查."),void 0===t.data&&void 0===t.url&&r.throwError("Navbar error:请为Navbar配置数据源."),void 0!==t.data&&"object"==typeof t.data){var l=e(t.data);c.html(l),n.init(),i.config.elem=c}else if(t.cached){var o=layui.data("tb_navbar");if(void 0===o.navbar)a.ajax({type:t.type,url:t.url,async:!1,dataType:"json",success:function(i,a,r){layui.data("tb_navbar",{key:"navbar",value:i});var t=e(i);c.html(t),n.init()},error:function(i,e,a){r.msgError("Navbar error:"+a)},complete:function(e,a){i.config.elem=c}});else{var l=e(o.navbar);c.html(l),n.init(),i.config.elem=c}}else layui.data("tb_navbar",null),a.ajax({type:t.type,url:t.url,async:!1,dataType:"json",success:function(i,a,r){var t=e(i);c.html(t),n.init()},error:function(i,e,a){r.msgError("Navbar error:"+a)},complete:function(e,a){i.config.elem=c}});if(t.spreadOne){c.children("ul").find("li.layui-nav-item").each(function(){a(this).on("click",function(){a(this).siblings().removeClass("layui-nav-itemed")})})}return i},t.prototype.set=function(i){var e=this;return e.config.data=void 0,a.extend(!0,e.config,i),e},t.prototype.on=function(i,e){var n=this,t=n.config.elem;"string"!=typeof i&&r.throwError("Navbar error:事件名配置出错，请参考API文档.");var c=i.indexOf("("),l=i.substr(0,c);i.substring(c+1,i.indexOf(")"));"click"===l&&void 0!==t.attr("lay-filter")&&t.children("ul").find("li").each(function(){var i=a(this);if(i.find("dl").length>0){i.find("dd").each(function(){a(this).on("click",function(){var i=a(this).children("a"),n=i.data("url"),r=i.children("i:first").data("icon"),t=i.children("cite").text();e({elem:i,field:{href:n,icon:r,title:t}})})})}else i.on("click",function(){var a=i.children("a"),n=a.data("url"),r=a.children("i:first").data("icon"),t=a.children("cite").text();e({elem:a,field:{href:n,icon:r,title:t}})})})},t.prototype.cleanCached=function(){layui.data("tb_navbar",null)};var c=new t;i("navbar",function(i){return c.set(i)})});