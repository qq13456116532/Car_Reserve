//不可逆加盐算法加密
//将加密后的密码保存到数据库，而不是保存明文密码，避免拖库等事件发生后，明文密码外泄。

//不可逆算法指加密过程中不需要使用密钥，输入明文后由系统直接经过加密算法处理成密文，
//这种加密后的数据是无法被解密的，只有重新输入明文，并再次经过同样不可逆的加密算法处理，
//得到相同的加密密文并被系统重新识别后，才能真正解密。

//这里使用不可逆加密算法MD5
//MD5（Message-Digest Algorithm）是计算机安全领域广泛使用的散列函数（又称哈希算法、摘要算法）。
//主要用来确保消息的完整性和一致性。
//常见的应用场景有：密码保护、下载文件校验等。

//当攻击者知道算法是md5后，可以将实现准备好的常见明文密码的md5值来进行匹配暴力破解
//所以要进行"加盐"处理
//在密码的特定位置插入特定字符串后，再对修改的字符串进行md5运算
//同样的密码，当“盐”值不一样的时候，md5的值差异非常大
//通过密码加盐，可以防止最初级的暴力破解，如果攻击者事先不知道“盐”值，破解的难度就会非常大
//对于前端来说，没有绝对的加密，毕竟js文件是暴露的
//只能用来拖延黑客时间

let salt = "HELLOhtmlImZHANGliang@5201314,<.>/?;:'[china]"

function strToBinary(str) {
    let result = [];
    let list = str.split("");
    for (let i = 0; i < list.length; i++) {
        if (i !== 0) {
            result.push((salt[i % (salt.length - 1)]).charCodeAt(0).toString(2)); //加入转换成二进制的盐
        }
        let item = list[i];
        let binaryStr = item.charCodeAt(0).toString(3); //原字符转为asc2后转换为三进制
        result.push(binaryStr);
    }
    return result.join("110");
}

function jiamipassword(text) {
    return md5(md5(strToBinary(text))) //md5加密两次
}

function jiamitoken(text) {
    return md5(text + "这是个验证用户的token")
}