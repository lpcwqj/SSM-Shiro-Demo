package realm;

import beans.User;
import org.apache.shiro.authc.*;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.realm.AuthenticatingRealm;
import org.apache.shiro.util.ByteSource;
import service.UserService;
import javax.annotation.Resource;

/**
 * @author Lin
 * @Date 2019/6/11
 *
 * 自定义Realm 查询数据库并返回数据
 *
 *         1.把AuthenticationToken转换为UsernamePasswordToken
 *         2.从UsernamePasswordToken中获取username
 *         3.调用数据库方法，查询username对应的用户记录
 *         4.若用户不存在，则可以抛出UnKnownAccountException异常
 *         5.根据用户信息情况，决定是否要抛出其他的AuthenticationException异常(用户锁定等等。。。)
 *         6.根据用户情况，来构建AuthenticationInfo对象并返回,通常使用的实现类是SimpleAuthenticationInfo
 *          以下数据通过查找数据库获取(用户名、密码、当前Realm的名字(调用父类的getName方法))
 */
public class shiroRealm extends AuthenticatingRealm {

    @Resource
    private UserService userService;

    /**
     * 认证
     */
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken)
            throws AuthenticationException {

        UsernamePasswordToken token = (UsernamePasswordToken)authenticationToken;
        String username = token.getUsername();
        User user = userService.checkUserByUsername(username);
        if (user==null){
            throw new UnknownAccountException("用户'"+username+"'不存在");
        }
//        封装数据
        Object principal = username;
        Object credential = user.getPassword();
        ByteSource salt = ByteSource.Util.bytes(username);  //用户名作为盐值
        String realmName = this.getName();
        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(principal,credential,salt,realmName);
//        返回给调用login(token)方法
        return info;
    }
}
