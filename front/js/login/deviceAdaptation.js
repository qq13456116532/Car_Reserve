//进行浏览器适配、多设备适配

function deviceAdaptation() {
//适配大小屏幕、电脑屏幕
    function displayChange() {
        let webwidth = document.body.clientWidth;
        let big = false;
        if (webwidth > 800) {//网页可见宽度大于800，如ipad、手机横屏、电脑屏幕
            big = true;
        }
        if (big)
            document.getElementById("mainBox").className = "boxbig"
        else
            document.getElementById("mainBox").className = "box"
    }

    displayChange()//先适配一次大小
    window.onresize = function () {//监听浏览器宽度改变
        displayChange()
    };
    //尝试适配浏览器
    //获取浏览器信息
    let info = []

    function getExplorerInfo() {
        let explorer = window.navigator.userAgent.toLowerCase();
        let ver
        if (explorer.indexOf("msie") >= 0 || explorer.indexOf("Msie") >= 0) {
            ver = explorer.match(/msie ([\d.]+)/)[1];
            info.push("IE");
            info.push(ver.toString());
        }
        //firefox
        else if (explorer.indexOf("firefox") >= 0 || explorer.indexOf("Firefox") >= 0) {
            ver = explorer.match(/firefox\/([\d.]+)/)[1];
            info.push("Firefox");
            info.push(ver.toString());
        }
        //Chrome
        else if (explorer.indexOf("chrome") >= 0 || explorer.indexOf("Chrome") >= 0) {
            ver = explorer.match(/chrome\/([\d.]+)/)[1];
            info.push("Chrome");
            info.push(ver.toString());
        }
        //Opera
        else if (explorer.indexOf("opera") >= 0 || explorer.indexOf("Opera") >= 0) {
            ver = explorer.match(/opera.([\d.]+)/)[1];
            info.push("Opera");
            info.push(ver.toString());
        }
        //Safari
        else if (explorer.indexOf("safari") >= 0 || explorer.indexOf("Safari") >= 0) {
            if (explorer.indexOf("iP") < 0 && navigator.platform.indexOf("ac") >= 0 && explorer.indexOf("obile") < 0) {
                ver = explorer.match(/version\/([\d.]+)/)[1];
                info.push("Safari");
                info.push(ver.toString());
            } else if (navigator.platform.indexOf("iP") < 0 && navigator.platform.indexOf("ip") < 0) {
                info.push("浏览器设备模拟器");
                info.push("");
            } else {
                ver = explorer.match(/version\/([\d.]+)/)[1];
                info.push("Safari");
                info.push(ver.toString());
            }
        } else {
            info.push("null")
            info.push((explorer.match(/version\/([\d.]+)/)[1]).toString())
        }
    }

    //显示不兼容（旧版浏览器不支持不加分号的js）（无法修正的兼容）
    function tooOld(web, ver) {
        console.log("您的浏览器为" + web + ver + "，不支持此网页，请升级后再访问！")
        window.open("https://www.google.cn/chrome/")
    }

    //显示建议升级
    function needUpdate(web, ver) {
        console.log("您的浏览器为" + web + ver + "，显示效果非最佳，建议升级至最新版" + web + "浏览器")
    }

    //safari浏览器建议更换
    function needChange(ver) {
        console.log("您的浏览器为Safari" + ver + "，显示效果非最佳，建议升级至最新版Chrome浏览器")
    }

    //修改背景颜色的渐变
    function changeBGColor() {
        if (document.getElementById("sessionBox").className === "sectionNormal")
            document.getElementById("sessionBox").className = "sectionOld"
        else
            document.getElementById("sessionBox").className = "sectionNormal"
    }

    //chrome 旧版颜色异常
    function closeColor() {
        while (document.getElementsByClassName("color").length > 0) {
            let colorCard = document.getElementsByClassName("color")
            for (let i = 0; i < colorCard.length; i++)
                colorCard[i].className = ""
        }
        changeBGColor()
    }

    //浏览器适配
    function OldChang() {
        //已知问题的版本：
        //chrome < 53  背景颜色渐变样式有问题
        //chrome < 48  不支持es6，js无法使用let
        //IE JS加载有问题、背景颜色渐变样式有问题、窗口定位有问题
        //Firefox < 44  JS加载有问题(需要分号)
        //Opera < 30  不支持es6，js无法使用let
        //Safari  背景颜色渐变样式有问题
        getExplorerInfo()
        console.log("浏览器：" + info[0] + info[1])
        switch (info[0]) {
            case "Chrome": {
                if (parseFloat(info[1].toString()) < 53.0) {
                    if (parseFloat(info[1].toString()) < 48.0) {
                        tooOld(info[0], info[1])
                    } else {
                        closeColor()
                        needUpdate(info[0], info[1])
                    }
                }
                break;
            }
            case "Firefox": {
                if (parseFloat(info[1].toString()) < 44.0) {
                    tooOld(info[0], info[1])
                }
                break;
            }
            case "IE": {
                tooOld(info[0], info[1])
                break;
            }
            case "Opera": {
                if (parseFloat(info[1].toString()) < 30.0) {
                    tooOld(info[0], info[1])
                }
                break;
            }
            case "Safari": {
                changeBGColor();
                needChange(info[1])
                break;
            }
            case "浏览器设备模拟器": {
                console.log("检测到您模拟的设备为iPhone设备，模拟浏览器为Safari，我们无法判断您的兼容性，建议您关闭设模拟器，使用真实设备浏览")
                console.log("背景颜色特效已为您开启，如显示异常请在控制台中输入changeBGColor()关闭一些特效")
                break;
            }
            default: {
                changeBGColor();//保险一点
                console.log("您的浏览器可能显示效果非最佳或者有问题，建议下载最新版Chrome浏览器")
            }
        }
    }

    OldChang()
}