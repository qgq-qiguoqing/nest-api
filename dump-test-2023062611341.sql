-- MySQL dump 10.13  Distrib 8.0.28, for macos11 (x86_64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `id` int NOT NULL AUTO_INCREMENT,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `author` varchar(255) NOT NULL,
  `authorEmail` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(1000) NOT NULL,
  `nameID` varchar(255) NOT NULL,
  `abstract` varchar(1000) NOT NULL,
  `isHot` tinyint NOT NULL DEFAULT '0',
  `content` json NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (5,'2023-06-19 07:11:24','2023-06-19 07:11:24','qiguoqing','18439339670@163.com','react技术栈','ChatGPT对话为什么不用Websocket而使用EventSource？','1686625934501','3',1,'\"<p><span style=\\\"color: rgb(51, 51, 51);\\\"><img src=\\\"https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/1fa998db8f0547a6a2a8f4fdfd5f8eea~tplv-k3u1fbpfcp-zoom-crop-mark:1512:1512:1512:851.awebp?\\\" alt=\\\"ChatGPT对话为什么不用Websocket而使用EventSource？\\\" style=\\\"border-style: none; position: relative; object-fit: cover; width: 755.938px; color: rgb(51, 51, 51); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;system-ui&quot;, &quot;Helvetica Neue&quot;, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, Arial; font-size: 12px; white-space: normal;\\\"></span>在ChatGPT官网我们可以看到，对话的方式仅仅只有一个<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">post</code>请求，而没有使用<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">IM</code>中使用的<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">websocket</code>链接。</p><p><img src=\\\"https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b3611aa0196d4adab9126d60e82cbd66~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp?\\\" alt=\\\"image.png\\\" style=\\\"border-style: none; z-index: 10000; cursor: zoom-in; max-width: 100%; transition: transform 0.3s cubic-bezier(0.2, 0, 0.2, 1) 0s !important;\\\"></p><p>同时我们可以看到与普通的<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">post</code>请求不一样的是，返回信息<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">Response</code>没有了，取而代之的是<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventStream</code>。</p><p>那么这个<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventStream</code>是什么东西？</p><p>一通查证后，发现这个是Web API中的<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>接口返回的数据。</p><p>MDN的官方描述是这样的(<a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FEventSource\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(2, 105, 200);\\\">传送门</a>)：</p><blockquote><code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>&nbsp;接口是 web 内容与服务器发送事件 一个&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>&nbsp;实例会对HTTP服务器开启一个持久化的连接，以&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">text/event-stream</code>&nbsp;格式发送事件，此连接会一直保持开启直到通过调用&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource.close()</code>&nbsp;关闭。</blockquote><p>好家伙，还有这好东西。是我以前孤陋寡闻了。</p><p>经过一番对比，总结了一下&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>&nbsp;和&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">Websocket</code>&nbsp;的区别和优劣：</p><p><strong>EventSource</strong>:</p><ul><li>优势：</li><li class=\\\"ql-indent-1\\\">简单易用：EventSource API非常简单，易于使用和理解。</li><li class=\\\"ql-indent-1\\\">服务器推送：EventSource适用于服务器主动向客户端推送数据，客户端只能接收服务器发送的事件。</li><li class=\\\"ql-indent-1\\\">自动重连：EventSource会自动处理连接断开和重新连接的情况，适用于长期保持连接并接收事件流的场景。</li><li class=\\\"ql-indent-1\\\">兼容性：EventSource在大多数现代浏览器中得到支持。</li><li>劣势：</li><li class=\\\"ql-indent-1\\\">单向通信：EventSource只支持从服务器到客户端的单向通信，客户端无法向服务器发送数据。</li><li class=\\\"ql-indent-1\\\">较少的功能：相比于WebSocket，EventSource提供的功能较为有限，仅限于接收服务器发送的事件。</li></ul><p><strong>WebSocket</strong>:</p><ul><li>优势：</li><li class=\\\"ql-indent-1\\\">双向通信：WebSocket支持双向通信，客户端和服务器可以彼此发送数据。</li><li class=\\\"ql-indent-1\\\">实时性：WebSocket提供了更低的延迟和更快的数据传输速度，适用于实时性要求较高的应用场景。</li><li class=\\\"ql-indent-1\\\">丰富的功能：WebSocket提供了更多的功能，例如数据帧的自定义和二进制数据的传输等。</li><li>劣势：</li><li class=\\\"ql-indent-1\\\">复杂性：WebSocket API相对于EventSource更为复杂，使用起来可能需要更多的代码和理解。</li><li class=\\\"ql-indent-1\\\">需要服务器支持：使用WebSocket需要服务器端实现对应的WebSocket协议，而EventSource只需要服务器端支持发送事件即可。</li><li class=\\\"ql-indent-1\\\">兼容性：相对于EventSource，WebSocket在某些较旧的浏览器或网络环境中的支持可能不够广泛。</li></ul><p>综上所述，<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>&nbsp;适用于服务器主动推送事件给客户端，并且在保持长期连接和接收事件流时表现良好。&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">WebSocket</code>&nbsp;适用于需要实时双向通信和更丰富功能的场景，但需要服务器端和客户端都支持&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">WebSocket</code>&nbsp;协议，选择使用哪种技术应基于具体需求和应用场景进行评估。</p><p>那么有了上面的结论我们再来看看，为什么&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">ChatGPT</code>&nbsp;对话为什么不用&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">Websocket</code>&nbsp;而使用&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>&nbsp;？</p><p>当然，<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">ChatGPT</code>&nbsp;对话可以使用<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">Websocket</code>或<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>进行实时通信，下面是我个人的总结：</p><ol><li>服务器推送：<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>专注于服务器向客户端主动推送事件的模型，这对于<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">ChatGPT</code>对话非常适用。<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">ChatGPT</code>通常是作为一个长期运行的服务，当有新的回复可用时，服务器可以主动推送给客户端，而不需要客户端频繁发送请求。</li><li>自动重连和错误处理：<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>具有内置的自动重连机制，它会自动处理连接断开和重新连接的情况。这对于<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">ChatGPT</code>对话而言很重要，因为对话可能需要持续一段时间，连接的稳定性很重要。</li><li>简单性和易用性：相对于<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">WebSocket</code>，<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>的API更加简单易用，只需实例化一个<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>对象，并处理服务器发送的事件即可。这使得开发者可以更快速地实现对话功能，减少了一些复杂性。</li><li>广泛的浏览器支持：<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">EventSource</code>在大多数现代浏览器中得到广泛支持，包括移动端浏览器。相比之下，<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">WebSocket</code>在某些旧版本的浏览器中可能不被完全支持，需要考虑兼容性问题。</li></ol><p>需要注意的是，<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(255, 245, 245);\\\">WebSocket</code>也是一种很好的选择，特别是当需要实现更复杂的实时双向通信、自定义协议等功能时，或者对浏览器的兼容性要</p>\"'),(10,'2023-06-19 07:48:47','2023-06-19 07:48:47','qiguoqing','18439339670@163.com','nest技术栈','nestjs使用心得','1686625948406','阅读本文前建议先了解 React 渲染相关流程与基本原理，以下是之前针对源码写的粗略文章：',1,'\"<p class=\\\"ql-align-justify\\\"><span style=\\\"color: rgb(51, 51, 51);\\\"><img src=\\\"https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/085cd759cac14d49bb85459b9b31cb5b~tplv-k3u1fbpfcp-zoom-crop-mark:1512:1512:1512:851.awebp?\\\" alt=\\\"你真的会用<a>标签下载文件吗?\\\" style=\\\"border-style: none; position: relative; object-fit: cover; width: 755.938px; color: rgb(51, 51, 51); font-family: -apple-system, system-ui, &quot;Segoe UI&quot;, Roboto, Ubuntu, Cantarell, &quot;Noto Sans&quot;, sans-serif, &quot;system-ui&quot;, &quot;Helvetica Neue&quot;, &quot;PingFang SC&quot;, &quot;Hiragino Sans GB&quot;, &quot;Microsoft YaHei&quot;, Arial; font-size: 12px; white-space: normal;\\\"></span>最近和后端联调下载时忽然发现屡试不爽的 &lt;a&gt; 标签下载失灵了？这才感觉自己对文件下载一直处在一知半解的模糊状态中，趁端午前夕有空赶紧总结了一下，和大家一起讨论讨论。</p><h2>&lt;a&gt; 标签 download</h2><p class=\\\"ql-align-justify\\\">这应该是最常见，最受广大人民群众喜闻乐见的一种下载方式了，搭配上&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">download</code>&nbsp;属性， 就能让浏览器将链接的 URL 视为下载资源，而不是导航到该资源。</p><p class=\\\"ql-align-justify\\\">如果&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">download</code>&nbsp;再指定个&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">filename</code>&nbsp;，那么就可以在下载文件时，将其作为预填充的文件名。不过名字中的&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">/</code>&nbsp;和&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">\\\\</code>&nbsp;会被转化为下划线&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">_</code>，而且文件系统可能会阻止文件名中的一些字符，因此浏览器会在必要时适当调整文件名。</p><h3>封装下载方法</h3><p class=\\\"ql-align-justify\\\">贴份儿我常用的下载方法：</p><pre class=\\\"ql-syntax\\\" spellcheck=\\\"false\\\">\\nts\\n复制代码\\nconst downloadByUrl = (url: string, filename: string) =&gt; {\\n    if (!url) throw new Error(\'当前没有下载链接\');\\n\\n    const a = document.createElement(\\\"a\\\");\\n    a.style.display = \\\"none\\\";\\n    a.href = url;\\n    a.download = filename;\\n    // 使用target=\\\"_blank\\\"时，添加rel=\\\"noopener noreferrer\\\" 堵住钓鱼安全漏洞 防止新页面window指向之前的页面\\n    a.rel = \\\"noopener noreferrer\\\";\\n    document.body.append(a);\\n    a.click();\\n\\n    setTimeout(() =&gt; {\\n        a.remove();\\n    }, 1000);\\n};\\n</pre><h4>Firefox 不能一次点击多次下载</h4><p class=\\\"ql-align-justify\\\">这里有个兼容性问题：在火狐浏览器中，当一个按钮同时下载多个文件（调用多次）时，只能下载第一个文件。所以，我们可以利用 &lt;a&gt; 标签的&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">target</code>&nbsp;属性，将其设置成&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">_blank</code>&nbsp;让火狐在一个新标签页中继续下载。</p><pre class=\\\"ql-syntax\\\" spellcheck=\\\"false\\\">\\nts\\n复制代码\\n// 检查浏览器型号和版本\\nconst useBrowser = () =&gt; {\\n    const ua = navigator.userAgent.toLowerCase();\\n    const re = /(msie|firefox|chrome|opera|version).*?([\\\\d.]+)/;\\n    const m = ua.match(re);\\n    const Sys = {\\n        browser: m[1].replace(/version/, \\\"\'safari\\\"),\\n        version: m[2]\\n    };\\n\\n    return Sys;\\n};\\n</pre><p class=\\\"ql-align-justify\\\">添加一个浏览器判断：</p><pre class=\\\"ql-syntax\\\" spellcheck=\\\"false\\\">\\nts\\n复制代码\\nconst downloadByUrl = (url: string, filename: string) =&gt; {\\n    // 略......\\n\\n    //  火狐兼容\\n    if (useBrowser().browser === \\\"firefox\\\") {\\n        a.target = \\\"_blank\\\";\\n    }\\n\\n    document.body.append(a);\\n}\\n</pre><h3>download 使用注意点</h3><p class=\\\"ql-align-justify\\\">&lt;a&gt; 标签虽好，但还有一些值得注意的点：</p><h4>1. 同源 URL 的限制</h4><blockquote class=\\\"ql-align-justify\\\">download 只在同源 URL 或&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(246, 251, 255);\\\">blob:</code>&nbsp;、&nbsp;<code style=\\\"color: rgb(255, 80, 44); background-color: rgb(246, 251, 255);\\\">data:</code>&nbsp;协议起作用</blockquote><p class=\\\"ql-align-justify\\\">也就是说跨域是下载不了的......</p><p class=\\\"ql-align-justify\\\">首先，非同源 URL 会进行导航操作。其次，如果非要下载，那么正如上面的文档所说，可以先将其转换为&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">blob:</code>&nbsp;或&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">data:</code>&nbsp;再进行下载，至于如何转换会在&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Blob</code>&nbsp;章节中详细介绍。</p><h4>2. 无法鉴权</h4><p class=\\\"ql-align-justify\\\">使用 &lt;a&gt; 标签下载是带不了&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Header</code>&nbsp;的，因此也不能携带登录态，所以无法进行鉴权。这里我们给出一个解决方案：</p><ol><li>先发送请求获取&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">blob</code>&nbsp;文件流，这样就能在请求时进行鉴权；</li><li>鉴权通过后再执行下载操作。</li></ol><p class=\\\"ql-align-justify\\\">这样是不是就能很好的同时解决问题1和问题2带来的两个痛点了呢😃</p><p class=\\\"ql-align-justify\\\">顺便提一下，<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">location.href</code>&nbsp;和&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">window.open</code>&nbsp;也存在同样的问题。</p><h4>3. download 与 Content-Disposition 的优先级</h4><p class=\\\"ql-align-justify\\\">这里需要关注一个响应标头&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Content-Disposition</code>，它会影响 &lt;a&gt;的&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">download</code>&nbsp;从而可能产生不同的下载行为，先看一个真实下载链接的&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Response Headers</code>：</p><p class=\\\"ql-align-justify\\\"><span style=\\\"color: rgb(51, 51, 51);\\\"><img src=\\\"https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c1a3ed67530b48aaa2a00af74e6bf0dc~tplv-k3u1fbpfcp-zoom-in-crop-mark:1512:0:0:0.awebp?\\\" alt=\\\"Snipaste_2023-06-20_18-19-21.png\\\" style=\\\"border-style: none; z-index: 10000; cursor: zoom-in; max-width: 100%; transition: transform 0.3s cubic-bezier(0.2, 0, 0.2, 1) 0s !important;\\\"></span></p><p class=\\\"ql-align-justify\\\"><span style=\\\"color: rgb(51, 51, 51);\\\">如图所示，</span><code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Content-Disposition</code>&nbsp;的 value 值为&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">attachment;filename=aaaa.bb</code>。请记住，此时<strong>Content-Disposition 的 filename 优先级会大于 &lt;a&gt; download 的优先级</strong>。也就是说，当两者都指定了&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">filename</code>&nbsp;时，会优先使用&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Content-Disposition</code>&nbsp;中的文件名。</p><p class=\\\"ql-align-justify\\\">接下来我们看看这个响应标头到底是什么。</p><h2>Content-Disposition</h2><blockquote class=\\\"ql-align-justify\\\">在常规的 HTTP 应答中，Content-Disposition 响应标头指示回复的内容该以何种形式展示，是以内联的形式（即网页或者页面的一部分），还是以附件的形式下载并保存到本地。</blockquote><p class=\\\"ql-align-justify\\\">与&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Content-Type</code>&nbsp;不同，后者用来指示资源的 MIME 类型，比如资源是图片（<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">image/png</code>）还是一段 JSON（<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">application/json</code>），而&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Content-Disposition</code>&nbsp;则是用来指明该资源是直接展示在页面上的，还是应该当成附件下载保存到本地的。</p><p class=\\\"ql-align-justify\\\">当它作为 HTTP 消息主题的标头时，有以下三种写法：</p><pre class=\\\"ql-syntax\\\" spellcheck=\\\"false\\\">\\ntxt\\n复制代码\\nContent-Disposition: inline\\nContent-Disposition: attachment\\nContent-Disposition: attachment; filename=\\\"filename.jpg\\\"\\n</pre><h3>inline</h3><p class=\\\"ql-align-justify\\\">默认值，即指明资源是直接展示在页面上的。 但是在同源 URL 情况下，&lt;a&gt; 元素的&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">download</code>&nbsp;属性优先级比&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">inline</code>&nbsp;大，浏览器优先使用&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">download</code>&nbsp;属性来处理下载（Firefox 早期版本除外）。</p><h3>attachment</h3><p class=\\\"ql-align-justify\\\">即指明资源应该被下载到本地，大多数浏览器会呈现一个 “保存为” 的对话框，如果此时有&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">filename</code>，那么它将其优于&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">download</code>&nbsp;属性成为下载的预填充文件名。</p><h3>&lt;a&gt;标签 VS Content-Disposition</h3><p class=\\\"ql-align-justify\\\">介绍完&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Content-Disposition</code>，我们做一个横向比对的归纳一下：</p><ul><li class=\\\"ql-align-justify\\\">download VS inline/attachment</li><li class=\\\"ql-align-justify\\\">优先级：attachment &gt; download &gt; inline</li><li class=\\\"ql-align-justify\\\">download 的值 VS filename</li><li class=\\\"ql-align-justify\\\">优先级：filename &gt; download 的值</li></ul><h2>Blob 转换</h2><p class=\\\"ql-align-justify\\\">前文介绍到，在非同源请情况下可以将资源当成二进制的 blob 先拿到手，再进行 &lt;a&gt; 的下载处理。接下来，我们介绍两种 blob 的操作：</p><h3>方法1. 用作 URL（blob:）</h3><p class=\\\"ql-align-justify\\\"><a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FURL%2FcreateObjectURL_static\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">URL.createObjectURL</a>&nbsp;可以给&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">File</code>&nbsp;或&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Blob</code>&nbsp;生成一个URL，形式为&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">blob:&lt;origin&gt;/&lt;uuid&gt;</code>，此时浏览器内部就会为每个这样的 URL 存储一个 URL → Blob 的映射。因此，此类 URL 很短，但可以访问 Blob。</p><p class=\\\"ql-align-justify\\\">那这就好办多了，写成代码就三行：</p><pre class=\\\"ql-syntax\\\" spellcheck=\\\"false\\\">\\njs\\n复制代码\\nimport downloadByUrl from \\\"@/utils/download\\\";\\n\\nconst download = async () =&gt; {\\n  const blob = await fetchFile();\\n\\n  // 生成访问 blob 的 URL\\n  const url = URL.createObjectURL(blob);\\n\\n  // 调用刚刚封装的 a 标签下载方法\\n  downloadByUrl(url, \\\"表格文件.xlsx\\\");\\n  \\n  // 删除映射，释放内存\\n  URL.revokeObjectURL(url);\\n};\\n</pre><p class=\\\"ql-align-justify\\\">不过它有个副作用。虽然这里有&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Blob</code>&nbsp;的映射，但&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Blob</code>&nbsp;本身只保存在内存中的。浏览器无法释放它。</p><p class=\\\"ql-align-justify\\\">在文档退出时（unload），该映射会被自动清除，因此&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Blob</code>&nbsp;也相应被释放了。但是，如果应用程序寿命很长，那这个释放就不会很快发生。</p><p class=\\\"ql-align-justify\\\"><strong>因此，如果我们创建一个 URL，那么即使我们不再需要该&nbsp;</strong><code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\"><strong>Blob</strong></code><strong>&nbsp;了，它也会被挂在内存中。</strong></p><p class=\\\"ql-align-justify\\\"><span style=\\\"color: rgb(51, 51, 51);\\\">不过，</span><a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FURL%2FrevokeObjectURL_static\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">URL.revokeObjectURL</a>&nbsp;可以从内部映射中移除引用，允许&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Blob</code>&nbsp;被删除并释放内存。所以，在即时下载完资源后，不要忘记立即调用 URL.revokeObjectURL。</p><h3>方法2. 转换为 base64（data:）</h3><p class=\\\"ql-align-justify\\\">作为&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">URL.createObjectURL</code>&nbsp;的一个替代方法，我们也可以将&nbsp;Blob&nbsp;转换为 base64-编码的字符串。这种编码将二进制数据表示为一个由 0 到 64 的 ASCII 码组成的字符串，非常安全且“可读”。</p><p class=\\\"ql-align-justify\\\">更重要的是 —— 我们可以在 “data-url” 中使用此编码。<a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh%2Fdocs%2FWeb%2Fhttp%2FData_URIs\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">“data-url”</a>&nbsp;的形式为&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">data:[&lt;mediatype&gt;][;base64],&lt;data&gt;</code>。我们可以在任何地方使用这种 url，和使用“常规” url 一样。</p><p class=\\\"ql-align-justify\\\"><a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FFileReader\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">FileReader</a>&nbsp;是一个对象，其<strong>唯一目的</strong>就是从 Blob 对象中读取数据，我们可以使用它的&nbsp;<a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FFileReader%2FreadAsDataURL\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">readAsDataURL</a>&nbsp;方法将 Blob 读取为 base64。请看以下示例：</p><pre class=\\\"ql-syntax\\\" spellcheck=\\\"false\\\">\\njs\\n复制代码\\nimport downloadByUrl from \\\"@/utils/download\\\";\\n\\nconst download = async () =&gt; {\\n  const blob = await fetchFile();\\n\\n  // 声明一个 fileReader\\n  const fileReader = new FileReader();\\n  \\n  // 将 blob 读取成 base64\\n  fileReader.readAsDataURL(blob);\\n  \\n  // 读取成功后 下载资源\\n  fileReader.onload = function () {\\n      downloadByUrl(fileReader.result);\\n  };\\n};\\n</pre><p class=\\\"ql-align-justify\\\">在上述例子中，我们先实例化了一个&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">fileReader</code>，用它来读取 blob。</p><p class=\\\"ql-align-justify\\\">一旦读取完成，就可以从 fileReader 的&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">result</code>&nbsp;属性中拿到一个<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">data:&nbsp;URL</code>&nbsp;格式的 Base64 字符串。</p><p class=\\\"ql-align-justify\\\">最后，我们给 fileReader 注册了一个&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">onload</code>&nbsp;事件，在读取操作完成后开始下载。</p><h3>两种方法总结与对比</h3><p class=\\\"ql-align-justify\\\"><code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">URL.createObjectURL(blob)</code>&nbsp;可以直接访问，无需“编码/解码”，但需要记得撤销（revoke）；</p><p class=\\\"ql-align-justify\\\">而&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Data URL</code>&nbsp;无需撤销（revoke）任何操作，但对大的&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Blob</code>&nbsp;进行编码时，性能和内存会有损耗。</p><p class=\\\"ql-align-justify\\\">总而言之，这两种从&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Blob</code>&nbsp;创建 URL 的方法都可以用。但通常&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">URL.createObjectURL(blob)</code>&nbsp;更简单快捷。</p><h3>responseType</h3><p class=\\\"ql-align-justify\\\">最后，我们回头说一下请求的注意点：如果你的项目使用的是&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">XHR</code>&nbsp;（比如 axios）而不是&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">fetch</code>， 那么请记得在请求时添加上&nbsp;<a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FXMLHttpRequest%2FresponseType\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">responseType</a>&nbsp;为 \'blob\'。</p><pre class=\\\"ql-syntax\\\" spellcheck=\\\"false\\\">\\njs\\n复制代码\\nexport const fetchFile = async (params) =&gt; {\\n  return axios.get(api, {\\n    params,\\n    responseType: \\\"blob\\\"\\n  });\\n};\\n</pre><p class=\\\"ql-align-justify\\\"><code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">responseType</code>&nbsp;不是 axios 中的属性，而是&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">XMLHttpRequest</code>&nbsp;中的属性，它用于指定响应中包含的数据类型，当为 \\\"blob\\\" 时，表明&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Response</code>&nbsp;是一个包含二进制数据的&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">Blob</code>&nbsp;对象。</p><p class=\\\"ql-align-justify\\\">除了&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">blob</code>&nbsp;之外，responseType 还有&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">arraybuffer</code>、<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">json</code>、<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">text</code>等其他枚举字符串值。</p><h2>总结</h2><p class=\\\"ql-align-justify\\\">一言以蔽之，同源就直接使用&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">&lt;a&gt; download</code>&nbsp;下载，跨域就先获取&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">blob</code>，用&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">createObjectURL</code>&nbsp;或&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">readAsDataURL</code>&nbsp;读取链接，再用&nbsp;<code style=\\\"color: rgb(11, 83, 147); background-color: rgb(246, 251, 255);\\\">&lt;a&gt; download</code>&nbsp;下载。</p><h2>参考资料</h2><ul><li><a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FHTML%2FElement%2Fa\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">&lt;a&gt;：锚元素 | MDN</a></li><li><a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FHTTP%2FHeaders%2FContent-Disposition\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">Content-Disposition | MDN</a></li><li><a href=\\\"https://juejin.cn/post/7207078219215732794#heading-14\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">PDF 预览和下载你是怎么实现的</a></li><li><a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fzh.javascript.info%2Fblob\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">Blob | 现代 JavaScript 教程</a></li><li><a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FURL%2FcreateObjectURL_static\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">URL.createObjectURL | MDN</a></li><li><a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FURL%2FrevokeObjectURL_static\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">URL.revokeObjectURL | MDN</a></li><li><a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FHTTP%2FBasics_of_HTTP%2FData_URLs\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">Data URL | MDN</a></li><li><a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FFileReader\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">FileReader | MDN</a></li><li><a href=\\\"https://link.juejin.cn/?target=https%3A%2F%2Fdeveloper.mozilla.org%2Fzh-CN%2Fdocs%2FWeb%2FAPI%2FXMLHttpRequest%2FresponseType\\\" rel=\\\"noopener noreferrer\\\" target=\\\"_blank\\\" style=\\\"color: rgb(0, 50, 94);\\\">XMLHttpRequest.responseType | MDN</a></li></ul><p><br></p>\"');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classification`
--

DROP TABLE IF EXISTS `classification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `classification` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nameID` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classification`
--

LOCK TABLES `classification` WRITE;
/*!40000 ALTER TABLE `classification` DISABLE KEYS */;
INSERT INTO `classification` VALUES (1,'1686625918742','java技术栈1','2023-06-13 03:11:58'),(2,'1686625926463','vue技术栈','2023-06-13 03:12:06'),(3,'1686625934501','react技术栈','2023-06-13 03:12:14'),(4,'1686625948406','nest技术栈','2023-06-13 03:12:28'),(5,'1686628017043','新增分类','2023-06-13 03:46:57');
/*!40000 ALTER TABLE `classification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,' 无忧',NULL,'961a41ae046cccc03ee238755c025d3c3140','http://localhost:3000/uploads/931683598990_.pic_hd.jpg','18439339670@163.com',NULL,'gZnSUg==','2023-06-09 09:53:16','2023-06-09 09:53:16');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'test'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-26 11:34:29
