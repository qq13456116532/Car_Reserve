//开启框架检测，防止恶意越权访问
const frameOpen = false;
//判断是否在iframe中
frameOpen ? checkFrame() : void (0);

function checkFrame() {
    if (self.frameElement && self.frameElement.tagName === "IFRAME")
        return true;
    else {
        window.location.replace("403.html") //非app访问该页面（即不是通过index的iframe访问的）拒绝访问。
        return false;
    }
}