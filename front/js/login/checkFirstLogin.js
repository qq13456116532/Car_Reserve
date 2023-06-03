function checkFirstLogin() {
    if (localStorage.getItem("FirstTimeLogin")) {
        return false;
    } else {
        let d = new Date()
        localStorage.setItem("FirstTimeLogin", d.getTime())
        // //初始化一些默认账号
        // register("admin", "admin", "admin", jiamipassword("admin"), true, true);//管理员用户
        // register("教务处老师", "1000003", "helloword", jiamipassword("hellohtml"), false, true, true)//教务处审核老师
        // register("汪彩霞", "1000001", "wangcaixia", jiamipassword("wangcaixia"), false)//老师用户（自带高级权限）
        // register("张亮", "2201904240", "zl1424625705", jiamipassword("zhangliang"), false, true)//高级用户
        // register("叶怡麟", "2201904171", "yeyilin", jiamipassword("yeyilin"))//普通用户
        return true;
    }
}