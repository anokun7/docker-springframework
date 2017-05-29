package hello;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;

@RestController
public class HelloController {

//    @Value("#{environment['HOSTNAME']}")
//    private String hostName;

    @RequestMapping("/")
    public String index() {
        return "Hello from " + System.getenv("HOSTNAME") + String.format("%n");
    }
}
