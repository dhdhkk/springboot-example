package com.iot.hyundai.springboot.web;
import com.iot.hyundai.springboot.web.dto.HelloResponseDto;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {
    private final Logger logger = LoggerFactory.getLogger("STDOUT");

    @GetMapping("/hello")
    public String hello()
    {
        return "hello";
    }

    @GetMapping("/hello/dto")
    public HelloResponseDto helloDto(@RequestParam("name") String name, @RequestParam("amount") int amount) {
        return new HelloResponseDto(name, amount);
    }

    @GetMapping("/health")
    public String checkHealth()
    {
        String profile = System.getProperty("spring.profiles.active");
        logger.debug("TEST" + profile);

        return "healthy";
    }
}
