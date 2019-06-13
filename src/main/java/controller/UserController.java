package controller;

import beans.User;
import com.mysql.cj.core.util.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import service.UserService;
import utils.PageUtils;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * @author Lin
 * @Date 2019/5/28
 */

@Controller
public class UserController {
    @Resource
    private UserService userService;

    /**
     * 用户登录 采用shiro
     * 当某用户登录成功之后，shiro安全框架就会将用户的信息存放在session中，
     * 你可以通过User user = (User) SecurityUtils.getSubject().getPrincipal();
     * 这句代码在任何地方任何时候都能获取当前登录成功的用户信息
     */
    @RequestMapping("login")
    public String checkLogin(@RequestParam(value = "username") String username,
                             @RequestParam(value = "password") String password,
                             Model model)
    {
        String msg = null;
        if (StringUtils.isNullOrEmpty(username)||StringUtils.isNullOrEmpty(password)){
            msg = "登录失败,用户名/密码不能为空";
            model.addAttribute("msg",msg);
            return "login";
        }
        //获取主体信息，即登录信息
        Subject currentUser = SecurityUtils.getSubject();
        //如果当前用户没有登录
        if (!currentUser.isAuthenticated()){
            UsernamePasswordToken token = new UsernamePasswordToken(username,password);
            token.setRememberMe(true);
            try{
                //该login方法的底层代码实现了获取一个或多个Realm的方法
                currentUser.login(token);
            }
            catch (UnknownAccountException e){
                msg = "登录失败,"+e.getMessage();
                model.addAttribute("msg",msg);
                return "login";
            }
            catch (IncorrectCredentialsException e){
                msg = "登录失败，密码不正确";
                model.addAttribute("msg",msg);
                return "login";
            }
        }
        return "redirect:home";
    }

    /**
     * 跳转到主页面
     * 实现分页显示
     */
    @RequestMapping("home")
    public String findAll(@RequestParam(value = "currentPage",defaultValue = "1") Integer currentPage,
                          Model model,
                          HttpServletRequest request)
    {
        String username_fuzzy = (String) request.getSession().getAttribute("username_fuzzy");
        //点击return to home按钮后 删除刚输入的模糊字段的session值
        if (username_fuzzy!=null){
            request.getSession().removeAttribute("username_fuzzy");
        }
        PageUtils<User> page = userService.findByPage(currentPage,null);
        model.addAttribute("page",page);
        return "home";
    }

    /**
     * 模糊查询 分页显示
     *
     * 此分页和主页的分页采用同一种方法，主页的分页的username传值null，该页的分页传值为用户输入的username
     */
    @RequestMapping("fuzzyQuery")
    public String fuzzyQuery(@RequestParam(value = "currentPage",defaultValue = "1") Integer currentPage,
                             Model model,
                             HttpServletRequest request){
        //获取输入的模糊字段
        String username = request.getParameter("username");
        //获取session中的模糊字段名
        //当点击下一页请求时，只传来currentPage值，username的值得从session中获取

        //第一次访问fuzzyQuery页面时，即第一页，模糊字段存入session中
        if (!StringUtils.isNullOrEmpty(username)){
            request.getSession().setAttribute("username_fuzzy",username);
            PageUtils<User> page = userService.findByPage(currentPage,username);
            model.addAttribute("page1",page);
        }
        //当点击下一页时 获取session中的模糊字段
        //此时 查询的两个条件齐了.currentPage是前台传过来的,username是获取之前存入session中、用户输入的模糊字段
        else {
            //如果第一次登录成功后立马点击模糊查询 判断session中是否有相应的值 没有则重定向
            if (request.getSession().getAttribute("username_fuzzy")==null){
                return "redirect:home";
            }
            String username1 = (String) request.getSession().getAttribute("username_fuzzy");
            PageUtils<User> page = userService.findByPage(currentPage,username1);
            model.addAttribute("page1",page);
        }
        return "fuzzyQuery";
    }

    /**
     * ajax传json字符串 回显数据
     */
    @RequestMapping("toEdit")
    public @ResponseBody
    User selectUserById(@RequestParam(value = "id") Integer id)
    {
        return userService.selectUserById(id);
    }

    /**
     * 修改信息
     */
    @RequestMapping("update")
    public @ResponseBody
    String update(User user)
    {
        userService.update(user);
        return "OK";
    }

    /**
     * 删除
     */
    @RequestMapping("delete")
    public @ResponseBody
    String delete(@RequestParam(value = "id") Integer id)
    {
        userService.delete(id);
        return "OK";
    }

    /**
     * 批量删除
     */
    @RequestMapping("batchDeletion")
    public String batchDeletion(@RequestParam(required = false) Integer[] ids,
                                HttpServletRequest request)
    {
        String username_fuzzy = (String) request.getSession().getAttribute("username_fuzzy");
        if (ids==null){
            //判断是在主页面还是在模糊查询页面进行的批量删除
            if (username_fuzzy==null||"".equals(username_fuzzy)){
                return "forward:/home";
            }
            return "forward:/fuzzyQuery";
        }
        userService.batchDeletion(ids);
        return "redirect:/home";
    }

    /**
     * 添加用户
     */
    @RequestMapping("add")
    public @ResponseBody
    String add(User user)
    {
        userService.add(user);
        return "OK";
    }
}
