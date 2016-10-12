# GofMediator

<p style="margin-left: 30px;">看了limboy和Casa的文章，关于组件化开发，整理了一下思路。</p>
<h2>1.为什么要进行组件化开发？</h2>
<p>　　一个产品，在最开始的时候，由于业务简单，一般是直接在一个工程里开发。这种方式，在产品起步阶段，是没有问题的，也能够有效的保证开发效率。但随着业务的不断发展，代码量不断增多，开发团队不断壮大，最后的模块间关系会发展成如下图所示：</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://images2015.cnblogs.com/blog/992921/201609/992921-20160907141028894-526079291.png" alt="" /></p>
<p style="text-align: left; margin-left: 30px;">从上图中可以看到，这种单一工程开发模式存在一些弊端：</p>
<ul>
<li>模块间耦合严重(<strong>模块是指较大粒度的业务功能。</strong>比如说微信，我们根据首页Tab，可以分为四大模块：会话、通讯录、发现、我)。示例代码片段如下：</li>
</ul>
<div class="cnblogs_code">
<pre>- (void)gotoFileDetailVC {<br />　　OpenFileViewController *vc =<span style="color: #000000;"> [[OpenFileViewController alloc] initWithFileModel:model];
　　[self.navigationController pushViewController:vc animated:YES];<br />}</span></pre>
</div>
<p style="margin-left: 30px;">上面这种方式在初期没什么问题，但项目越来越大的时候，每个模块都离不开其他模块，互相依赖在一起。</p>
<ul>
<li>合并代码的时候容易出现冲突(特别是XIB、Storyboard、project文件，如果一个大产品是用Storyboard来开发页面的话，特别是几个模块共用一个Storyboard的，那在合并代码的时候就只能自求多福了)；</li>
<li>业务方的开发效率不高(只关心自己业务模块的开发，却要编译整个项目，与其他不相干的代码糅合在一起)。</li>
</ul>
<h2>2.以什么方式实现组件化？</h2>
<h3><span style="font-size: 1.17em; line-height: 1.5;">2.1基于中间件的Target-Action(推荐)</span></h3>
<p style="margin-left: 30px;">&nbsp;从第一部分，我们知道单一工程开发模式下的问题，这里我们会用基于中间件的Target-Action方式，来对业务模块间的关系进行解耦，先看一下最终的结构图：</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://images2015.cnblogs.com/blog/992921/201609/992921-20160907172835769-289940647.png" alt="" /></p>
<p style="margin-left: 30px;">从上图可以看到：</p>
<ul>
<li>各业务模块完全隔离，没有依赖关系；</li>
<li>业务模块依赖中间件模块的Category。</li>
</ul>
<p style="margin-left: 30px;">但是从上图中，大家可能会提出两个问题：</p>
<ol>
<li>组件化之后，多出了一个中间件模块，每个业务模块多了一个Target类，真有必要为了组件化而付出这个代价吗？</li>
<li>既然在中间件模块可以用Runtime来解耦，为什么不直接在业务模块来用Runtime进行解耦？</li>
</ol>
<h4 style="margin-left: 30px;">第一个问题：组件化之后，多出了一个中间件模块，每个业务模块多了一个Target类，真有必要为了组件化而付出这个代价吗？</h4>
<p style="margin-left: 30px;">这个问题的答案，其实在第一部分的为什么要做组件化说过了，这里再补充一句：</p>
<p style="margin-left: 30px;">使用Runtime，除了让中间件没有了编译依赖，还能在运行时去判断处理组件不存在的情况，代码片段如下：</p>
<p style="margin-left: 30px;"><img style="display: block; margin-left: auto; margin-right: auto;" src="http://images2015.cnblogs.com/blog/992921/201609/992921-20160907145616269-401962540.png" alt="" /></p>
<p>　　所以中间件是不依赖任何业务模块的，调用者和中间件模块可以单独使用。</p>
<h4 style="margin-left: 30px;">第二个问题 ：既然在中间件模块可以用Runtime来解耦，为什么不直接在业务模块来用Runtime进行解耦？</h4>
<p style="margin-left: 30px;">看一下在业务模块A中直接使用Runtime调用业务模块B的代码：</p>
<div class="cnblogs_code">
<pre>Class cls = NSClassFromString(<span style="color: #800000;">@"</span><span style="color: #800000;">GofTargetBModule</span><span style="color: #800000;">"</span><span style="color: #000000;">);
UIViewController </span>*reviewVC = [cls performSelector:NSSelectorFromString(<span style="color: #800000;">@"</span><span style="color: #800000;">actionBViewCtrlWithParam:</span><span style="color: #800000;">"</span>) withObject:@{<span style="color: #800000;">@"</span><span style="color: #800000;">title</span><span style="color: #800000;">"</span>:<span style="color: #800000;">@"</span><span style="color: #800000;">模块B</span><span style="color: #800000;">"</span><span style="color: #000000;">}];
[self.navigationController pushViewController:reviewVC animated:YES];</span></pre>
</div>
<p style="margin-left: 30px;">这种调用方式存在几个问题：</p>
<ul>
<li>调用的时候，编写代码没有提示，写起来比较麻烦，容易出错。</li>
<li>runtime方法的参数个数和类型限制，<span class="inline_code"><span class="inline_code">NSDictionary里的键值该传什么不明确。</span></span></li>
<li>编译器层面不依赖模块B，但是直接在这里调用，没有引入调用的组件时程序就会直接崩掉。</li>
</ul>
<p>　　现在我们从几个关键类的代码来看一下具体的实现细节。 下图是Demo的文件结构和流程图：</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://images2015.cnblogs.com/blog/992921/201609/992921-20160907175253535-1178871829.png" alt="" /></p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;<img style="display: block; margin-left: auto; margin-right: auto;" src="http://images2015.cnblogs.com/blog/992921/201609/992921-20160907183155316-718451711.png" alt="" /></p>
<p style="margin-left: 30px;">首先，是中间件类GofMediator，这个类的.h文件声明如下：</p>
<div class="cnblogs_code">
<pre><span style="color: #0000ff;">@interface</span><span style="color: #000000;"> GofMediator : NSObject

</span>+<span style="color: #000000;"> (instancetype)sharedInstance;

</span><span style="color: #008000;">/*</span><span style="color: #008000;">*
 *  远程调用
 *
 *  @param url url(统一格式示例：Gof://targetA/actionB?id=1234&amp;name=LeeGof)
 *
 *  @return YES/NO
 </span><span style="color: #008000;">*/</span>
- (BOOL)performRemoteActionWithUrl:(NSURL *<span style="color: #000000;">)url;

</span><span style="color: #008000;">/*</span><span style="color: #008000;">*
 *  本地调用
 *
 *  @param target 响应者
 *  @param action 动作
 *  @param params 参数
 *
 *  @return id类型
 </span><span style="color: #008000;">*/</span>
- (<span style="color: #0000ff;">id</span>)performNativeWithTarget:(NSString *<span style="color: #000000;">)target
                       action:(NSString </span>*<span style="color: #000000;">)action
                       </span><span style="color: #0000ff;">params</span>:(NSDictionary *)<span style="color: #0000ff;">params</span><span style="color: #000000;">;

</span><span style="color: #0000ff;">@end</span></pre>
</div>
<p style="margin-left: 30px;">提供了一个远程调用和本地调用的方法，其中远程调用方式的URL，最好是固定一下格式，这样可以统一的解析和跳转。</p>
<p style="margin-left: 30px;">接下来看一下调用方的代码，这样方便追根溯源。</p>
<div class="cnblogs_code">
<pre>UIViewController *vc =<span style="color: #000000;"> [[GofMediator sharedInstance] mediatorBViewController];
[self.navigationController pushViewController:vc animated:YES];</span></pre>
</div>
<p style="margin-left: 30px;">调用方用到了<span style="color: #ff0000;"><strong>GofMediator</strong></span>的<strong><span style="color: #ff0000;">mediatorBViewController</span></strong><span style="color: #000000;">方法，继续看这个方法的实现：</span></p>
<div class="cnblogs_code">
<pre>- (UIViewController *<span style="color: #000000;">)mediatorBViewController
{
    UIViewController </span>*viewController = [self performNativeWithTarget:<span style="color: #800000;">@"</span><span style="color: #800000;">B</span><span style="color: #800000;">"</span> action:<span style="color: #800000;">@"</span><span style="color: #800000;">BViewCtrlWithParam:</span><span style="color: #800000;">"</span> <span style="color: #0000ff;">params</span>:@{<span style="color: #800000;">@"</span><span style="color: #800000;">title</span><span style="color: #800000;">"</span>: <span style="color: #800000;">@"</span><span style="color: #800000;">模块B</span><span style="color: #800000;">"</span><span style="color: #000000;">}];
    
    </span><span style="color: #0000ff;">if</span> ([viewController isKindOfClass:[UIViewController <span style="color: #0000ff;">class</span><span style="color: #000000;">]])
    {
        </span><span style="color: #0000ff;">return</span><span style="color: #000000;"> viewController;
    }
    </span><span style="color: #0000ff;">else</span>  <span style="color: #008000;">//</span><span style="color: #008000;">处理异常</span>
<span style="color: #000000;">    {
        </span><span style="color: #0000ff;">return</span><span style="color: #000000;"> nil;
    }
}</span></pre>
</div>
<p>　　可以看到，在上面方法的实现中，调用了GofMediator的本地调用方法来生成viewController，这个本地调用方法(文章上面贴出了该方法代码)是通过Runtime，最终调用<span class="s1"><strong><span style="color: #ff0000;">GofTargetBModule</span></strong>的</span><span class="s1">actionBViewCtrlWithParam方法。</span></p>
<div class="cnblogs_code">
<pre>- (UIViewController *)actionBViewCtrlWithParam:(NSDictionary *<span style="color: #000000;">)param
{
    GofBViewController </span>*vc = [[GofBViewController alloc] initWithTitle:param[<span style="color: #800000;">@"</span><span style="color: #800000;">title</span><span style="color: #800000;">"</span><span style="color: #000000;">]];
    </span><span style="color: #0000ff;">return</span><span style="color: #000000;"> vc;
}</span></pre>
</div>
<p>　　在这里会最终生成GofBViewController实例并返回。</p>
<p>　　【总结】：这种方案，<span style="color: #ff0000;"><strong>组件之间通过中间件进行通信，中间件通过 runtime 解耦调用业务组件的 target-action ，通过 category 分离各业务组件接口代码</strong></span>。</p>
<p>&nbsp;</p>
<h3>2.2基于URL的注册表方式和protocol-class 注册表</h3>
<p>　　这是蘑菇街采用的方式，详情可以参考李忠的两篇文章。&nbsp;</p>
<p id="activity-name" class="rich_media_title">　　<a href="http://limboy.me/tech/2016/03/10/mgj-components.html" target="_blank">蘑菇街App的组件化之路</a></p>
<p class="rich_media_title">　　<a href="http://limboy.me/tech/2016/03/14/mgj-components-continued.html" target="_blank">蘑菇街 App 的组件化之路&middot;续</a></p>
<p class="rich_media_title">&nbsp;　　和上面一样，我们先看看结构图：</p>
<p class="rich_media_title"><img style="display: block; margin-left: auto; margin-right: auto;" src="http://images2015.cnblogs.com/blog/992921/201609/992921-20160912104024930-7726749.png" alt="" /></p>
<p>　　通过上图，我们可以看到三点：</p>
<ul>
<li>各业务模块之间没有依赖，相互独立；</li>
<li>URL注册模块(中间件模块)不依赖任何其他模块；</li>
<li>各业务模块和调用者都依赖了URL注册模块。</li>
</ul>
<p><span style="line-height: 1.5;">　　这是从结构图表面看到的，下面我们从代码角度来分析，从代码我们可以看到更多。</span><span style="line-height: 1.5;">下图是Demo的文件结构和流程图：</span></p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://images2015.cnblogs.com/blog/992921/201609/992921-20160912104702305-2140653770.png" alt="" /></p>
<p>&nbsp;<img src="http://images2015.cnblogs.com/blog/992921/201609/992921-20160912110421867-1322602802.png" alt="" /></p>
<p>　　首先我们看一下注册URL的关键代码：</p>
<div class="cnblogs_code">
<pre>+ (<span style="color: #0000ff;">void</span><span style="color: #000000;">)initComponent
{
    [[GofRouter sharedInstance] registerURLPattern:</span><span style="color: #800000;">@"</span><span style="color: #800000;">Gof://aViewController/:title</span><span style="color: #800000;">"</span> toHandler:^<span style="color: #0000ff;">id</span>(<span style="color: #0000ff;">id</span><span style="color: #000000;"> param) {
        GofAViewController </span>*vc = [[GofAViewController alloc] initWithTitle:param[<span style="color: #800000;">@"</span><span style="color: #800000;">title</span><span style="color: #800000;">"</span><span style="color: #000000;">]];
        </span><span style="color: #0000ff;">return</span><span style="color: #000000;"> vc;
    }];
}</span></pre>
</div>
<p>　　这里，注册的效果是给GofRouter类的一个缓存字典，加入了一个URL和对应的回调函数。</p>
<p>　　接着我们看一下调用方的关键代码：</p>
<div class="cnblogs_code">
<pre>UIViewController *vc = [[GofRouter sharedInstance] openURL:<span style="color: #800000;">@"</span><span style="color: #800000;">Gof://aViewController/A模块</span><span style="color: #800000;">"</span> withParam:@{<span style="color: #800000;">@"</span><span style="color: #800000;">name</span><span style="color: #800000;">"</span>: <span style="color: #800000;">@"</span><span style="color: #800000;">Gof</span><span style="color: #800000;">"</span><span style="color: #000000;">}];
[self.navigationController pushViewController:vc animated:YES];</span></pre>
</div>
<p>　　从上面的描述，我们可以看到这种方式存在如下几个问题：</p>
<ul>
<li>需要对可用URL进行管理。蘑菇街是有一个统一的后台进行管理；</li>
<li>每个URL都需要进行注册，并保存在内存中，这样URL多了的话，会出现内存问题；</li>
<li>参数为字典方式，具体怎么传，传什么字段，业务组件需要对这个字典进行说明和管理。</li>
</ul>
<h2>3.实际项目中怎样做组件化？&nbsp;</h2>
<p>　　在实际项目中，进行组件化开发，我们需要考虑如下的问题：</p>
<ol>
<li>怎样拆分组件？</li>
<li>采用什么方式来实现组件之间的通信？</li>
<li>怎样做代码的持续集成？</li>
<li>各端统一协调规范的问题。</li>
</ol>
<p>　　<strong>第一个问题：&nbsp;怎样拆分组件？</strong></p>
<p>　　对于组件化开发，最重要的是对各业务模块进行组件化，当然，也需要考虑一些基础组件，那么在实际的项目中，组件化可以考虑这样来设计：</p>
<p><img style="display: block; margin-left: auto; margin-right: auto;" src="http://images2015.cnblogs.com/blog/992921/201609/992921-20160912121729477-1057026108.png" alt="" /></p>
<p>　　关于基础组件：</p>
<ul>
<li>按功能划分，不涉及业务，可以理解为第三方库；</li>
<li>提供相应的API给业务组件使用。</li>
</ul>
<p>　　关于业务组件：</p>
<ul>
<li>业务组件之间相互独立，不存在依赖关系；</li>
<li>业务组件之间的调用，通过中间件组件实现；</li>
<li>业务组件之间应该去Model化。</li>
</ul>
<p>　<strong>　第二个问题：采用什么方式来实现组件之间的通信？</strong></p>
<p>　　这个问题在第二部分内容中已经详细描述了两种方式来实现组件之间的通信，本人比较推荐第一种方式：<strong><span style="color: #ff0000;">基于中间件的Target-Action</span></strong></p>
<p><strong>　　第三个问题：怎样做代码的持续集成？</strong></p>
<p>　　可以考虑采用submodule/subtree，也可以考虑使用Cocoapods的私有库来管理组件。</p>
<p><strong>　　第四个问题：各端统一协调规范的问题。</strong></p>
<p>&nbsp;　　一般很少有产品，在一开始就考虑组件化的问题。因为组件化是会带来开发成本的，当它的弊大于利的时候，我们通常会选择传统的单一工程开发模式，来快速开发出产品。随着产品的业务不断发展和快速迭代，开发团队规模的不断壮大，会暴漏前面提到的一些问题，这个时候我们会来思考一些改进方案，这就是组件化开发方案。但组件化开发方案，一方面是客户端需要统一设计和规划，那么相应的，其他各部门也要进行配合：</p>
<ol>
<li>服务端：对接口按组件划分进行统一管理。最好是有一个统一的空间，客户端、服务端按照组件，编写相应的文档，这样可以做到团队开发的传承性。另外，各组件团队，指定相应的负责人，每个组件最好是有两人，对一个组件的修改，最好是由负责人进行；如果是由别的组件团队人员修改，必须要经过该组件负责人同意，并且代码需要Review；</li>
<li>设计/产品：对产品进行统一规划，统一界面风格，协助抽取一些公用的UI。</li>
<li>测试：由于组件化开发一般是在产品相对成熟的阶段了，那么对产品进行组件化设计和开发的时候，需要测试对产品做一次全量回归测试。</li>
</ol>
<p>&nbsp;</p>
