//package neighborhooddoc.app.config;
//
///**
// * @Description
// */
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.stereotype.Component;
//import org.springframework.web.socket.server.standard.ServerEndpointExporter;
//
///**
// * @author Administrator
// */
//
//@Configuration
//@Component
//public class WebSocketConfig {
//
//    /**
//     * 服务器节点
//     *
//     * 如果使用独立的servlet容器，而不是直接使用springboot的内置容器，就不要注入ServerEndpointExporter，因为它将由容器自己提供和管理
//     */
//    @Bean
//    public ServerEndpointExporter serverEndpointExporter() {
//        return new ServerEndpointExporter();
//    }
//}
