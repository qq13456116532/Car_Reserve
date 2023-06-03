//利用localStorage模拟一个后端数据库

function utf8_to_b64(str) {//支持中文的base64加密解密
    if (str === null || str === 'null')
        return null;
    return window.btoa(unescape(encodeURIComponent(str)));
}

function b64_to_utf8(str) {
    if (str === null || str === 'null')
        return null;
    return decodeURIComponent(escape(window.atob(str)));
}

let user = {
    "name": "null",
    "username": "null",
    "type": "null",
    "id": "null",
    "highPermissions": "false",
    "admin": "true",
    "message": "0",
    "messageDetial": [],
    "certification": false,
    "phone": "null",
    "wechat": false,
    "apple": false,
    "serverKey": false,
    "qq": false,
    "xinyong": "100",
    "Broom": []
}

function register(name, id, username, pwd, admin = false, highPermissions = false, check = false) {
    let userObj = user;
    userObj.username = username;
    userObj.pwd = pwd;
    userObj.name = name;
    userObj.id = id;
    userObj.admin = admin;
    userObj.highPermissions = highPermissions;
    if (id[0] === "1" && id[1] === "0") {
        userObj.type = "tea"
        userObj.highPermissions = true;
    } else
        userObj.type = "stu"
    if (admin)
        userObj.type = "admin"
    userObj.checker = check
    userObj.message = Math.floor(Math.random() * 99);
    console.log(userObj)
    updateUser(userObj)
}

function registerJsonn(json) {
    console.log("数据接受成功");
    let userObj = user;
    userObj.username = json.userName
    userObj.name = json.name
    userObj.id = json.stuid
    userObj.type = json.type
    if (json.type.indexOf("管理员") !== -1)
        userObj.admin = true
    else
        userObj.admin = false
    userObj.highPermissions = json.highPermissions;
    userObj.qq = json.qq
    userObj.wechat = json.wechat
    userObj.apple = json.apple
    userObj.xinyong = json.xinyong
    userObj.serverKey = json.serverKey
    userObj.message = Math.floor(Math.random() * 99);
    userObj.certification = json.certification;
    userObj.phone = json.phone;
    updateUser(userObj)
}

function login(username, pwd) {
    let UserJsonString = localStorage.getItem(utf8_to_b64(username))
    let userObj = JSON.parse(b64_to_utf8(UserJsonString));
    if (userObj === undefined || userObj === null)
        return false;
    console.log(userObj)
    console.log(userObj.username === username)
    console.log(userObj.pwd === pwd)
    console.log(userObj.pwd)
    console.log(pwd)
    return userObj.username === username && userObj.pwd === pwd;
}

function getName(username) {
    let UserJsonString = localStorage.getItem(utf8_to_b64(username))
    let userObj = JSON.parse(b64_to_utf8(UserJsonString));
    return userObj.name;
}

function getUser(username) {

    if (username === null || username === 'null')
        return user;
    let UserJsonString = localStorage.getItem(utf8_to_b64(username))
    return JSON.parse(b64_to_utf8(UserJsonString));
}

function gettype(userOBJ) {
    if (userOBJ.type === "admin")
        return "管理员"
    else if (userOBJ.type === "tea")
        return "老师"
    else
        return "同学"
}

function updateUser(userObj) {
    let UserJsonString = JSON.stringify(userObj);
    localStorage.setItem(utf8_to_b64(userObj.username), utf8_to_b64(UserJsonString));
}

function newMessage(userObj, mes) {

}