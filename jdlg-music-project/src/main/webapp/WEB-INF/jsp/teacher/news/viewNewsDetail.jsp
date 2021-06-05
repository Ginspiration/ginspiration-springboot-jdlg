<%@include file="../../pages/web-url.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="<%=basePath%>static/plugins/jQuery/jquery-2.2.3.min.js"></script>
<script src="<%=basePath%>static/plugins/bootstrap/js/bootstrap.min.js"></script>
<script src="<%=basePath%>static/plugins/base64/base64.js"></script>

<%--图片轮换CSS--%>
<style>
    .lb-box {
        width: 80%;
        height: 320px;
        position: relative;
        overflow: hidden;
    }

    @media (max-width: 568px) {
        .lb-box {
            width: 76%;
            height: 220px;
        }
    }

    .lb-content {
        width: 100%;
        height: 100%;
    }

    .lb-item {
        width: 100%;
        height: 100%;
        display: none;
        position: relative;
    }

    .lb-item > a {
        width: 100%;
        height: 100%;
        display: block;
    }

    .lb-item > a > img {
        width: 100%;
        height: 100%;
    }

    .lb-item > a > span {
        width: 100%;
        display: block;
        position: absolute;
        bottom: 0px;
        padding: 15px;
        color: #fff;
        background-color: rgba(0, 0, 0, 0.7);
    }

    @media (max-width: 568px) {
        .lb-item > a > span {
            padding: 10px;
        }
    }

    .lb-item.active {
        display: block;
        left: 0%;
    }

    .lb-item.active.left {
        left: -100%;
    }

    .lb-item.active.right {
        left: 100%;
    }

    /*  */
    .lb-item.next,
    .lb-item.prev {
        display: block;
        position: absolute;
        top: 0px;
    }

    .lb-item.next {
        left: 100%;
    }

    .lb-item.prev {
        left: -100%;
    }

    .lb-item.next.left,
    .lb-item.prev.right {
        left: 0%;
    }

    .lb-sign {
        position: absolute;
        right: 10px;
        top: 0px;
        padding: 5px 3px;
        border-radius: 6px;
        list-style: none;
        user-select: none;
        background-color: rgba(0, 0, 0, 0.7);
    }

    .lb-sign li {
        width: 22px;
        height: 20px;
        font-size: 14px;
        font-weight: 500;
        line-height: 20px;
        text-align: center;
        float: left;
        color: #aaa;
        margin: auto 4px;
        border-radius: 3px;
        cursor: pointer;
    }

    .lb-sign li:hover {
        color: #fff;
    }

    .lb-sign li.active {
        color: #000;
        background-color: #EBEBEB;
    }

    .lb-ctrl {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        font-size: 30px;
        font-weight: 900;
        user-select: none;
        background-color: rgba(0, 0, 0, 0.7);
        color: #fff;
        border-radius: 5px;
        cursor: pointer;
        transition: all 0.1s linear;
    }

    @media (max-width: 568px) {
        .lb-ctrl {
            font-size: 30px;
        }
    }

    .lb-ctrl.left {
        left: -50px;
    }

    .lb-ctrl.right {
        right: -50px;
    }

    .lb-box:hover .lb-ctrl.left {
        left: 10px;
    }

    .lb-box:hover .lb-ctrl.right {
        right: 10px;
    }

    .lb-ctrl:hover {
        background-color: #000;
    }

</style>

<script>

    /*图片轮换功能*/
    /*添加图片*/
    $(function () {



        //1.存储的图片字符串分割
        let pic = "${news.newImgUrl}"
        pic = pic.split("&*&")

        //2.循环添加.lb-content的图片
        //2-1:先添加第一个作为起始
        if (pic.length > 1) { //若图片不止一张
            $("#lbContent").append("<div class='lb-item active'>\n" +
                "                       <a href='#'>\n" +
                "                           <img src='<%=basePath%>" + pic[0] + "' alt='图片丢失'>\n" +
                "                       </a>\n" +
                "                   </div>")
        } else if (pic.length === 1) {//若图片只有一张
            $("#lbContent").append("<div  > \n" +
                "                       <a href='#'>\n" +
                "                           <img style='width:400px' src='<%=basePath%>" + pic[0] + "' alt='图片丢失'>\n" +
                "                       </a>\n" +
                "                   </div>")
        } else { //没图片

        }

        //2-2:在添加未激活的图片
        for (let i = 1; i < pic.length; i++) {
            $("#lbContent").append("<div class='lb-item'>\n" +
                "                       <a href='#'>\n" +
                "                           <img src='<%=basePath%>" + pic[i] + "' alt='图片丢失'>\n" +
                "                       </a>\n" +
                "                   </div>")
        }
        //    3.添加轮播标志
        //    3-1：先添加第一个，带有class名
        if (pic.length > 1) {   //图片若大于一张，则添加轮播
            $("#lb-sign").append("<li class='active'>1</li>\n")
            for (let i = 1; i < pic.length; i++) {
                $("#lb-sign").append("<li>" + (i + 1) + "</li>\n")
            }
        }else if(pic.length === 1){
            $("#lb-sign").removeClass("lb-sign")
            $("#lb-ctrl-left").removeClass('lb-ctrl left')
            $("#lb-ctrl-right").removeClass('lb-ctrl right')
        }


    })


</script>

<div class="content-wrapper">
    <!-- 内容头部 -->
    <section class="content-header">
        <h1>
            ${sessionScope.tName}
            <small>(教师)</small>
        </h1>
    </section>

    <section class="content">
        <div class="nav-tabs-custom">
            <div class="tab-content" style="">
                <div class="active tab-pane" id="activity">
                    <h2 style="color: #0c0c0c;">${news.newTitle}</h2>
                    <br>

                    <%--图片轮换html--%>
                    <div class="row">
                        <%--/若没图片--%>
                        <c:if test="${news.newImgUrl == '' }" >
                            <div class="col-sm-12">
                                    <%--输出文字--%>
                                <div style="">${news.newContext}</div>
                            </div>
                        </c:if>

                        <%--若有图片--%>
                        <c:if test="${news.newImgUrl != '' }" >
                            <div class="col-sm-6">
                                    <%--输出文字--%>
                                <div style="">${news.newContext}</div>
                            </div>
                            <div id="picture">
                                <div class="col-sm-offset-6">
                                    <div class="lb-box form-group" id="lb-1">
                                        <!-- 轮播内容 -->
                                        <div class="lb-content" id="lbContent">

                                        </div>
                                        <!-- 轮播标志 -->
                                        <ol class="lb-sign" id="lb-sign">
                                        </ol>
                                        <!-- 轮播控件 -->

                                        <div class="lb-ctrl left" id="lb-ctrl-left">＜</div>
                                        <div class="lb-ctrl right" id="lb-ctrl-right">＞</div>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                    </div>

                        <br/>


                </div>
            </div>
        </div>
    </section>
</div>

<script>
    /**轮换js类，需调用
     * @desc 一个轮播插件
     * @author Mxsyx (zsimline@163.com)
     * @version 1.0.0
     */
    class Lb {
        constructor(options) {
            this.lbBox = document.getElementById(options.id);
            this.lbItems = this.lbBox.querySelectorAll('.lb-item');
            this.lbSigns = this.lbBox.querySelectorAll('.lb-sign li');
            this.lbCtrlL = this.lbBox.querySelectorAll('.lb-ctrl')[0];
            this.lbCtrlR = this.lbBox.querySelectorAll('.lb-ctrl')[1];

            // 当前图片索引
            this.curIndex = 0;
            // 轮播盒内图片数量
            this.numItems = this.lbItems.length;

            // 是否可以滑动
            this.status = true;

            // 轮播速度
            this.speed = options.speed || 600;
            // 等待延时
            this.delay = options.delay || 3000;

            // 轮播方向
            this.direction = options.direction || 'left';

            // 是否监听键盘事件
            this.moniterKeyEvent = options.moniterKeyEvent || false;
            // 是否监听屏幕滑动事件
            this.moniterTouchEvent = options.moniterTouchEvent || false;

            this.handleEvents();
            this.setTransition();
        }

        // 开始轮播
        start() {
            const event = {
                srcElement: this.direction == 'left' ? this.lbCtrlR : this.lbCtrlL
            };
            const clickCtrl = this.clickCtrl.bind(this);

            // 每隔一段时间模拟点击控件
            this.interval = setInterval(clickCtrl, this.delay, event);
        }

        // 暂停轮播
        pause() {
            clearInterval(this.interval);
        }

        /**
         * 设置轮播图片的过渡属性
         * 在文件头内增加一个样式标签
         * 标签内包含轮播图的过渡属性
         */
        setTransition() {
            const styleElement = document.createElement('style');
            document.head.appendChild(styleElement);
            const styleRule = `.lb-item {transition: left ${param['this'].speed}ms ease-in-out}`
            styleElement.sheet.insertRule(styleRule, 0);
        }

        // 处理点击控件事件
        clickCtrl(event) {
            if (!this.status) return;
            this.status = false;
            if (event.srcElement == this.lbCtrlR) {
                var fromIndex = this.curIndex,
                    toIndex = (this.curIndex + 1) % this.numItems,
                    direction = 'left';
            } else {
                var fromIndex = this.curIndex;
                toIndex = (this.curIndex + this.numItems - 1) % this.numItems,
                    direction = 'right';
            }
            this.slide(fromIndex, toIndex, direction);
            this.curIndex = toIndex;
        }

        // 处理点击标志事件
        clickSign(event) {
            if (!this.status) return;
            this.status = false;
            const fromIndex = this.curIndex;
            const toIndex = parseInt(event.srcElement.getAttribute('slide-to'));
            const direction = fromIndex < toIndex ? 'left' : 'right';
            this.slide(fromIndex, toIndex, direction);
            this.curIndex = toIndex;
        }

        // 处理滑动屏幕事件
        touchScreen(event) {
            if (event.type == 'touchstart') {
                this.startX = event.touches[0].pageX;
                this.startY = event.touches[0].pageY;
            } else {  // touchend
                this.endX = event.changedTouches[0].pageX;
                this.endY = event.changedTouches[0].pageY;

                // 计算滑动方向的角度
                const dx = this.endX - this.startX
                const dy = this.startY - this.endY;
                const angle = Math.abs(Math.atan2(dy, dx) * 180 / Math.PI);

                // 滑动距离太短
                if (Math.abs(dx) < 10 || Math.abs(dy) < 10) return;

                if (angle >= 0 && angle <= 45) {
                    // 向右侧滑动屏幕，模拟点击左控件
                    this.lbCtrlL.click();
                } else if (angle >= 135 && angle <= 180) {
                    // 向左侧滑动屏幕，模拟点击右控件
                    this.lbCtrlR.click();
                }
            }
        }

        // 处理键盘按下事件
        keyDown(event) {
            if (event && event.keyCode == 37) {
                this.lbCtrlL.click();
            } else if (event && event.keyCode == 39) {
                this.lbCtrlR.click();
            }
        }

        // 处理各类事件
        handleEvents() {
            // 鼠标移动到轮播盒上时继续轮播
            this.lbBox.addEventListener('mouseleave', this.start.bind(this));
            // 鼠标从轮播盒上移开时暂停轮播
            this.lbBox.addEventListener('mouseover', this.pause.bind(this));

            // 点击左侧控件向右滑动图片
            this.lbCtrlL.addEventListener('click', this.clickCtrl.bind(this));
            // 点击右侧控件向左滑动图片
            this.lbCtrlR.addEventListener('click', this.clickCtrl.bind(this));

            // 点击轮播标志后滑动到对应的图片
            for (let i = 0; i < this.lbSigns.length; i++) {
                this.lbSigns[i].setAttribute('slide-to', i);
                this.lbSigns[i].addEventListener('click', this.clickSign.bind(this));
            }

            // 监听键盘事件
            if (this.moniterKeyEvent) {
                document.addEventListener('keydown', this.keyDown.bind(this));
            }

            // 监听屏幕滑动事件
            if (this.moniterTouchEvent) {
                this.lbBox.addEventListener('touchstart', this.touchScreen.bind(this));
                this.lbBox.addEventListener('touchend', this.touchScreen.bind(this));
            }
        }

        /**
         * 滑动图片
         * @param {number} fromIndex
         * @param {number} toIndex
         * @param {string} direction
         */
        slide(fromIndex, toIndex, direction) {
            if (direction == 'left') {
                this.lbItems[toIndex].className = "lb-item next";
                var fromClass = 'lb-item active left',
                    toClass = 'lb-item next left';
            } else {
                this.lbItems[toIndex].className = "lb-item prev";
                var fromClass = 'lb-item active right',
                    toClass = 'lb-item prev right';
            }
            this.lbSigns[fromIndex].className = "";
            this.lbSigns[toIndex].className = "active";

            setTimeout((() => {
                this.lbItems[fromIndex].className = fromClass;
                this.lbItems[toIndex].className = toClass;
            }).bind(this), 50);

            setTimeout((() => {
                this.lbItems[fromIndex].className = 'lb-item';
                this.lbItems[toIndex].className = 'lb-item active';
                this.status = true;  // 设置为可以滑动
            }).bind(this), this.speed + 50);
        }
    }

    window.onload = function () {
        // 轮播选项
        const options = {
            id: 'lb-1',              // 轮播盒ID
            speed: 600,              // 轮播速度(ms)
            delay: 3000,             // 轮播延迟(ms)
            direction: 'left',       // 图片滑动方向
            moniterKeyEvent: true,   // 是否监听键盘事件
            moniterTouchEvent: true  // 是否监听屏幕滑动事件
        }
        const lb = new Lb(options);
        lb.start();
    }
</script>