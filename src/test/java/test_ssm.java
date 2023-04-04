import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class test_ssm {
    //首页
    @RequestMapping("/123")
    public String index(){
        //请求转发
        return "index";
    }
}
