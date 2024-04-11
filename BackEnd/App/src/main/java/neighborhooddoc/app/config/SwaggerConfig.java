package neighborhooddoc.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.ArrayList;

@Configuration
@EnableSwagger2
public class SwaggerConfig {
    @Bean
    public Docket docket() {
        return new Docket(DocumentationType.SWAGGER_2).apiInfo(apiInfo()).select()
                .apis(RequestHandlerSelectors.basePackage("neighborhooddoc.app.controller"))
                .build();
    }
    private ApiInfo apiInfo() {
        Contact contact = new Contact("Frocen", "", "s3738959@student.rmit.edu.au");
        return new ApiInfo(
                "Springboot and Flutter", // 标题
                "Frocen made back-end, database and Swagger", // 描述
                "v1.0", // 版本
                "", // 组织链接
                contact, // 联系人信息
                "Apach 2.0", // 许可
                "https://apache.org/licenses/LICENSE-2.0", // 许可连接
                new ArrayList<>()// 扩展
        );
    }
}
