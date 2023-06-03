//用来检测登陆、注册的输入问题
//将输入错误显示在页面上

//错误代码
let Error = ['0', '0', '0', '0', '0', '0', '0', '0', '0'];
let ErrorTxt = ['用户名必须以字母开头', '用户名长度需为8-15位', '密码长度需为8-15位', '两次输入的密码不一样', '还没有输入用户名哦', '还没输入密码哦', '请再次输入密码哦', '请输入学号哦', '请输入姓名哦']
let ErrorStatus = false;

//防止输入框读取到退格键\b
function noTuiGe(str) {
    if (str.indexOf("\b") === 0) {
        str[0] = " "
        str[1] = " "
    }
    return Trim(str)
}

//显示错误
function flushError(className) {
    ErrorStatus = false;
    let ErrorText = [];
    for (let i = 0; i < Error.length; i++) {
        if (Error[i] === "1") {
            ErrorText.push(ErrorTxt[i]);
            ErrorStatus = true;
        }
    }
    let ele = document.getElementsByClassName(className)
    for (let i = 0; i < ele.length; i++) { //清空错误显示
        ele[i].innerHTML = ""
    }
    for (let i = 0; i < (ErrorText.length <= 4 ? ErrorText.length : 4); i++) { //显示错误（最多4个）
        ele[i].innerHTML = ErrorText[i]
    }
    // console.log(ErrorText)
    // console.log(Error)
    if (ErrorText.length !== 0) {
        zc.value = "输入不合法，请检查"
        dl.value = "输入不合法，请检查"
    } else {
        zc.value = "Register"
        dl.value = "Login"
    }
}

//监听注册输入事件
document.getElementById("ZCloginName").addEventListener("keyup", function () { //用户名
    let str = noTuiGe(ZCloginName.value);
    let reg = new RegExp("[a-zA-Z]")
    if (reg.test(str[0]) || str[0].length === 0) { //正则首字符是否为字母
        Error[0] = "0"
    } else {
        Error[0] = "1"
    }
    if ((str.length >= 1 && str.length <= 15) || str.length === 0) {
        Error[1] = "0"
    } else {
        Error[1] = "1"
    }
    flushError("errorZHUCE")
})
document.getElementById("ZCpwd").addEventListener("keyup", function () { //密码
    let str = noTuiGe(ZCpwd.value);
    if ((str.length >= 1 && str.length <= 15) || str.length === 0) {
        Error[2] = "0"
    } else {
        Error[2] = "1"
    }
    flushError("errorZHUCE")
})
document.getElementById("ZCpwdCheck").addEventListener("keyup", function () { //第二个密码
    let str = noTuiGe(ZCpwd.value)
    let str1 = noTuiGe(ZCpwdCheck.value)
    if (str === str1) {
        Error[3] = "0"
    } else {
        Error[3] = "1"
    }
    flushError("errorZHUCE")
})
document.getElementById("ZCName").addEventListener("keyup", function () { //第二个密码
    let str1 = noTuiGe(ZCName.value)
    if (str1.length > 0) {
        Error[7] = "0"
    } else {
        Error[7] = "1"
    }
    flushError("errorZHUCE")
})
document.getElementById("ZCID").addEventListener("keyup", function () { //第二个密码
    let str1 = noTuiGe(ZCID.value)
    if (str1.length > 0) {
        Error[7] = "0"
    } else {
        Error[7] = "1"
    }
    flushError("errorZHUCE")
})
document.getElementById("ZCpwdCheck").addEventListener("keyup", function () { //第二个密码
    let str = noTuiGe(ZCpwd.value)
    let str1 = noTuiGe(ZCpwdCheck.value)
    if (str === str1) {
        Error[3] = "0"
    } else {
        Error[3] = "1"
    }
    flushError("errorZHUCE")
})
document.getElementById("zc").addEventListener("mousedown", function () { //按下提交时，全部检查
    let all = []
    all.push(noTuiGe(ZCloginName.value))
    all.push(noTuiGe(ZCpwd.value))
    all.push(noTuiGe(ZCpwdCheck.value))
    for (let i = 0; i < all.length; i++) {
        if (all[i].length === 0)
            Error[4 + i] = "1"
        else
            Error[4 + i] = "0"
    }
    flushError("errorZHUCE")
})
//监听登陆输入事件
document.getElementById("loginName").addEventListener("keyup", function () { //用户名
    let str = noTuiGe(loginName.value);
    let reg = new RegExp("[a-zA-Z]")
    if (reg.test(str[0]) || str[0].length === 0) { //正则首字符是否为字母
        Error[0] = "0"
    } else {
        Error[0] = "1"
    }
    if ((str.length >= 1 && str.length <= 15) || str.length === 0) {
        Error[1] = "0"
    } else {
        Error[1] = "1"
    }
    flushError("errorDENGLU")
})
document.getElementById("pwd").addEventListener("keyup", function () { //密码
    let str = noTuiGe(pwd.value);
    if ((str.length >= 1 && str.length <= 15) || str.length === 0) {
        Error[2] = "0"
    } else {
        Error[2] = "1"
    }
    flushError("errorDENGLU")
})
document.getElementById("dl").addEventListener("mousedown", function () { //按下提交时，全部检查
    let all = []
    all.push(noTuiGe(loginName.value))
    all.push(noTuiGe(pwd.value))
    for (let i = 0; i < all.length; i++) {
        if (all[i].length === 0)
            Error[4 + i] = "1"
        else
            Error[4 + i] = "0"
    }
    flushError("errorZHUCE")
})