//检查登陆状态
//cookie是不安全的，可以被修改
//当自动登陆时，或者一些需要登陆才能执行的操作时，就需要检查我们的cookie
//将用户名与token进行核对
//故做成单独的js，供其他页面调用
function getCookie(name) {
    let arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
    if (arr != null) return decodeURIComponent(arr[2]);
    return null;
}

function checkLogin() {
    let user = atob(getCookie("loginName")) //尝试获取用户名cookie
    let token = getCookie(btoa(btoa((user)))) //尝试获取token cookie
    if (user && token) {
        if (token.indexOf(jiamitoken(user)) !== -1) { //验证用户名和token
            console.log("登陆状态正常")
            return true //登陆状态正常
        }
    }
    console.log("登陆状态异常")
    return false //核对不上，异常
}

function getUserName() {
    return atob(getCookie("loginName"))
}